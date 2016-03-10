# gist-sweep

A similar tool to [git-sweep](http://lab.arc90.com/2012/04/03/git-sweep/), but for [Github Gists](http://gist.github.com).

## Usage

> gist-sweep -u adamdecaf

```
~/src/gist-sweep $ gist-sweep --help
Usage: gist-sweep [options]
    -v, -s                           Print verbose messages
    -c                               Read config from a different file
    -u USERNAME                      Username to sweep gists on
    -d NUM                           Days to keep (default=90)
    -p                               Include public gists
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
