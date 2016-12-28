require "gist/sweep/version"
require 'date'
require 'json'
require 'octokit'
require 'optparse'

module GistSweep
  class Sweep
    def parse_arguments()
      options = {
        :verbose => false,
        :config_file => "~/.gist-sweep",
        :public => false,
        :days => 90
      }

      OptionParser.new do |opts|
        opts.banner = "Usage: gist-sweep [options]"

        opts.on("-v", "-s", "Print verbose messages") do |v|
          options[:verbose] = v
        end

        opts.on("-V", "Show the version") do |v|
          puts "gist-sweep: #{Gist::Sweep::VERSION}"
        end

        opts.on("-c", "Read config from a different file") do |c|
          options[:config_file] = c
        end

        opts.on("-u USERNAME", "Username to sweep gists on") do |u|
          options[:username] = u
        end

        opts.on("-d NUM", "Days to keep (default=90)", Integer) do |d|
          options[:days] = d.to_i
        end

        opts.on("-p", "Include public gists") do |p|
          options[:public] = p
        end

      end.parse!

      options
    end

    def read_config_from_file(path)
      expanded_path = File.expand_path(path)
      if File.exists?(expanded_path)
        contents = File.read(expanded_path)
        if contents.chomp.empty?
          {}
        else
          JSON.parse(contents)
        end
      else
        {}
      end
    end

    def write_config_file(oauth_token, path)
      expanded_path = File.expand_path(path)
      File.write(expanded_path, JSON.generate({:oauth_token => oauth_token}))
      FileUtils.chmod(0400, expanded_path)
    end

    def load_github_api(config, file_path)
      if config["oauth_token"] and !config["oauth_token"].empty?
        Octokit::Client.new(:access_token => config["oauth_token"])
      else
        puts "You need to setup a 'Personal Access Token' to use with gist-sweep"
        puts "I'll wait for you to paste one in: "
        code = STDIN.gets.strip
        write_config_file(code, file_path)
        Octokit::Client.new(:access_token => code)
      end
    end

    def promot_to_remove_gists(gists)
      gists.each do |g|
        puts "#{g[:updated_at]} (#{g[:id]}) -- #{g[:description]}"
      end
      print "Remove #{gists.size} gists? (y/n) "
      line = STDIN.gets.strip
      if line == 'y'
        true
      else
        false
      end
    end

    def verbose_log(args, msg)
      if args[:verbose]
        puts msg
      end
    end

    def sweep(raw_args)
      args = parse_arguments()
      config = read_config_from_file(args[:config_file])
      github = load_github_api(config, args[:config_file])

      # pattern will be the first item in ARGV after options are parsed
      pattern = ARGV[0]

      if args[:username]
        min_age = DateTime.now - args[:days]
        verbose_log(args, "Removing gists older than #{min_age}")

        pattern_matcher = Regexp.new(pattern || "")

        gists_to_remove = github.gists(args[:username]).select do |g|
          remove_already = (!g[:public] or args[:public]) && (g[:updated_at].to_datetime < min_age)
          if pattern
            remove_already && pattern_matcher.match(g[:description])
          else
            remove_already
          end
        end

        if gists_to_remove.empty?
          puts "No gists to remove"
        else
          if promot_to_remove_gists(gists_to_remove)
            gists_to_remove.each do |g|
              verbose_log(args, "Deleting gist #{g[:id]}")
              github.delete_gist(g[:id])
            end
            puts "Swept gists."
          end
        end
      else
        abort "No username defined (with -u flag)."
      end
    end
  end
end
