# The Dude

[![Code Climate](https://codeclimate.com/github/adamphillips/the_dude.png)](https://codeclimate.com/github/adamphillips/the\_dude)
[![Build Status](https://travis-ci.org/adamphillips/the_dude.png?branch=master)](https://travis-ci.org/adamphillips/the\_dude)

The Dude is here to make your terminal life more chilled.

You preload The Dude with your commonly used commands. Then you run them.
Alternatively, The Dude already knows how to do a bunch of stuff for you.

For example:

```shell
$ dude fetch google.co.uk # opens a google.co.uk in lynx
$ dude show me pictures of cool stuff # opens a browser with a google images search for 'cool stuff'
$ dude wassup # starts top
```

### How can this be useful?

By giving a high-level interface to the command line, The Dude can make it
easier, particularly for the less command-line savvy, to get some of the power
of the command-line without all of the learning curve.

By combining Ruby and the shell, The Dude can make it very easy to write
complicated and powerful scripts. Even for those with high levels of
command-line fu, obscure or often forgotten commands can be given high-level
aliases making them easier to remember.

For example, imagine you have a remote web server containing log files that
occasionally need to be searched in a particular way if there is a problem.

So this would involve, ssh-ing into the server, navigating to the logs folder
and grep through the appropriate log file. None of these are particularly
tricky however there are plenty of opportunities to get bogged down such as
forgetting paths, grep options etc.

With The Dude you can easily setup a command to do this.

```ruby
command /search web logs for (.+)/ do |term|
  path = '/path/to/access.log'
  Net::SSH.start 'production.server', 'user' do |ssh|
    ssh.exec! "grep #{term} #{path}"
  end
end
```

After which you can simply type

```shell
$ dude search web logs for something
```

You can also call other dude commands. For example if we now wanted to list
page not found errors we could add the command

```ruby
command 'list not found' do
  ask 'search web logs for 404'
end
```

Then call it with

```shell
$ dude list not found
```

Whilst this can be handy (and kinda fun) for those who are comfortable on the
command line, its real benefit is to allow command-line savvy developers to enable
other members of their team to perform specific tasks without having to
remember complicated command line options and flags.

## Installing The Dude

You can install TheDude using

```shell
$ gem install the_dude
```

The Dude comes with a 'dude' binary so you can use this to run commands

```shell
$ dude why? # will output 'because'
```

Alternatively, you can start the dude interactively with

```shell
$ dude -i
```

Then you get a dude prompt with history that you can enter commands straight into.

## Creating commands

To add your own commands, create a file in your home folder called .duderc .
Then you can use [The Dude
DSL](https://github.com/adamphillips/the_dude/blob/master/lib/the_dude/dsl.rb)
to create commands. Some basic commands look like

```ruby
# dude hello world
command 'hello world', 'whatever man'

# open google search results in a browser
command /google (.*)/, ->(query){ `open "https://www.google.co.uk/search?q=#{query}"` }
```

You can list all available dude commands with

```shell
$ dude list commands
```

For a full list of all configured commands, variables and plugins use

```shell
$ dude what you got
```

## Installing plugins

You can install plugins for TheDude that contain additional commands or add
additional functionality. Plugins are bundled as gems. For example to install
the trello plugin simply use

```shell
$ gem install the_dude-trello
```

After setting your Trello authentication details, you will then be able to use
the commands defined in the Trello plugin as well as use them to build your own
commands.

```ruby
command /find (\S+) on ideas board/ do |text|
  ideas_board_id = 123 # Trello id of the ideas board
  ask "find #{text} on trello board #{ideas_board_id}"
end
```

will let you search across the titles of all cards on the board with the specified id.

```shell
$ dude find awesomeness on ideas board
```

### Available plugins

Currently the following plugins are available

[Web](https://github.com/adamphillips/the_dude-web) :
Integrates Capybara and Nokogiri for easier web scripts

[SSH](https://github.com/adamphillips/the_dude-ssh) :
Integrates SSH

[Trello](https://github.com/adamphillips/the_dude-trello) :
Connect to Trello boards, lists and cards.
