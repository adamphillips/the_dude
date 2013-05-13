# The Dude

[![Code Climate](https://codeclimate.com/github/adamphillips/the_dude.png)](https://codeclimate.com/github/adamphillips/the\_dude)

The Dude is here to make your terminal life more chilled.

You preload The Dude with your commonly used commands. Then you run them.
Alternatively, The Dude already knows how to do a bunch of stuff for you.

For example:

    $ dude fetch google.co.uk # opens a google.co.uk in lynx
    $ dude show me pictures of cool stuff # opens a browser with a google images search for 'cool stuff'
    $ dude wassup # starts top

If this sounds like fancypants bash aliases, you'd be about right. So what's the point?

Well, there's a few reasons
- a single dude command can trigger a bunch of other commands.  Sure you
  could write a shell script and run that using an alias but that assumes
  you're happy writing shell scripts.
- for the command-line phobic, dude provides a friendly interface to the
  command line.
- for those who are happy on the command line, there can still be a benefit
  in reducing the cognitive overhead required to run scripts

## Talking to The Dude

The Dude is still very young and not on rubygems quite yet. For the mean
time, you will need to checkout the repo and build the gem.

The Dude comes with a 'dude' binary so you can use this to run commands

    dude why? # will output 'because'

Alternatively, you can start the dude inteactively with

    dude -i

Then you get a dude prompt you can enter commands straight into.
