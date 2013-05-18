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

How can this be useful?
- a single dude command can trigger a bunch of other commands.  Sure you
  could write a shell script and run that using an alias but that assumes
  you're happy writing shell scripts.
- for the command-line phobic, dude provides a friendly interface to the
  command line.
- for those who are at home on the command line, there can still be a benefit
  in reducing the cognitive overhead required to run scripts.
- commands can be bundled and shared using gems meaning that command line savvy
  devs can set up simpler commands for other team members to use.

## Talking to The Dude

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

Then you get a dude prompt you can enter commands straight into.

## Installing plugins

You can install plugins for TheDude that contain additional commands or add additional functionality. Plugins are bundled as gems. For example to install the trello plugin simply use

```shell
$ gem install the_dude-trello
```

You will now be able to use the commands defined in the Trello plugin.

### Available plugins

Currently the following plugins are available

[Web](https://github.com/adamphillips/the_dude-web]
Integrates Capybara and Nokogiri for easier web scripts

[Trello](https://github.com/adamphillips/the_dude-ssh]
Integrates SSH

[Trello](https://github.com/adamphillips/the_dude-trello]
Connect to Trello boards, lists and cards.
