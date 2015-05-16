# gist-sweep

A similar tool to [git-sweep](http://lab.arc90.com/2012/04/03/git-sweep/), but for [Github Gists](http://gist.github.com).

## Usage

> gist-sweep -u adamdecaf

```
Usage: gist-sweep [options] [PATTERN]
    -v, -s                           Print verbose messages
    -c                               Read config from a different file
    -u                               Username to sweep gists on
    -d                               Days to keep
    -p                               Include public gists
    [pattern]                        Optional pattern to match gist descriptions to
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gist-sweep'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gist-sweep


## Contributing

Submit a PR to me and I'll probably merge it.
