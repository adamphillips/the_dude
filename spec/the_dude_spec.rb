require 'spec_helper'

describe TheDude do
  describe '.ask' do
    context 'when there is a matching regex question and proc command with params' do
      before :each do
        TheDude::Command.new /what is (\d+)\s*\+\s*(\d+)/, ->(v1, v2){ v1.to_i + v2.to_i }
      end

      describe 'the answer' do
        subject {TheDude.ask 'what is 4 + 3'}

        it {should == 7}
      end
    end
  end

  describe '.command' do
    context 'when passed a command' do
      context 'that has not been registered' do
        it 'should return false' do
          TheDude.command(/duff/).should be_false
        end
      end

      context 'that has been registered' do
        before :each do
          TheDude::Variable.new(:cool, /.*/).register
          @command = TheDude::Command.new(/something :cool/)
        end

        it 'should return the command' do
          TheDude.command(/something :cool/).should == @command
        end
      end
    end
  end

  describe '.register_command' do
    context 'when passed a command' do
      it 'should add the command to the commands collection' do
        @command = TheDude::Command.new 'hello', 'hello world'
        TheDude.register_command @command

        TheDude.commands.length.should == 1
        TheDude.commands[/^hello$/].should == @command
      end
    end
  end

  describe '.register_variable' do
    context 'when passed a variable' do
      it 'should add the variable to the variables collection' do
        @variable = TheDude::Variable.new :placeholder, /\S+/
        TheDude.register_variable @variable

        TheDude.variables.length.should == 1
        TheDude.variables[:placeholder].should == @variable
      end
    end
  end

  describe '.reset' do
    context 'when there are commands' do
      before :each do
        TheDude::Command.new 'hello', 'hello world'
      end

      it 'should empty the commands collection' do
        TheDude.reset
        TheDude.commands.should == {}
      end
    end
  end

  describe '.reset' do
    context 'when there are variables' do
      before :each do
        @var = TheDude::Variable.new :placeholder, /\S+/
        TheDude.register_variable @var
      end

      it 'should empty the variables collection' do
        TheDude.reset
        TheDude.variables.should == {}
      end
    end
  end
end
