require 'spec_helper'

describe TheDude::Command do
  describe '#initalize' do
    context 'when passed a string question and string command' do
      before :each do
        TheDude::Command.new 'why?', 'because'
      end

      describe 'TheDude.commands' do
        subject {TheDude.commands}
        its(:length) {should == 1}
      end

      describe 'TheDude.commands[/why\?/]' do
        subject {TheDude.commands[/^why\?$/]}

        it {should be_kind_of TheDude::Command}
        its(:answer) {should == 'because'}
      end
    end

    context 'when passed a string question and proc command' do
      before :each do
        TheDude::Command.new 'why?', ->{'because'}
      end

      describe 'TheDude.commands' do
        subject {TheDude.commands}
        its(:length) {should == 1}
      end

      describe 'TheDude.commands[/why\?/]' do
        subject {TheDude.commands[/^why\?$/]}

        it {should be_kind_of TheDude::Command}
        its(:answer) {should be_kind_of Proc}
      end
    end

    context 'when passed an expression question containing a defined variable' do
      before :each do
        TheDude::Variable.new(:server, /\S+/).register
        @command = TheDude::Command.new /connect to :server/, ->(server) {'connecting to #{server}'}
      end

      it 'should convert the expression to a normal regex' do
        @command.question.should == /connect to (\S+)/
      end
    end
  end

  describe '#ask' do
    context 'when passed a string that matches a string command' do
      it 'should return the associated string' do
        command = TheDude::Command.new 'hello', 'hello world'
        command.ask.should == 'hello world'
      end
    end

    context 'when passed a string that matches a regex command' do
      it 'should evaluate the answer' do
        command = TheDude::Command.new '(\d+)\s*\+\s*(\d+)', ->(a, b){a + b}
        command.ask(4, 3).should == 7
      end
    end
  end
end
