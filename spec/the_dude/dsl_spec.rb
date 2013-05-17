require 'spec_helper'

describe TheDude::Dsl do
  describe '#ask' do
    context 'when asked' do
      context 'and the command exists' do
        before :each do
          TheDude::Dsl.new.command 'hey', 'what'
        end
        it 'should perform the requested command' do
          TheDude::Dsl.new.ask('hey').should == 'what'
        end
      end
    end
  end

  describe '#command' do
    context 'when passed a question' do
      before :each do
        @question = 'hey'
      end

      context 'and a string answer' do
        it 'should register a new dude command' do
          TheDude::Dsl.new.command @question, 'what'
          TheDude.commands.length.should == 1
          TheDude.commands[/^hey$/].ask.should == 'what'
        end
      end

      context 'and a proc answer' do
        it 'should register a new dude command' do
          TheDude::Dsl.new.command @question, ->{'what'}
          TheDude.commands.length.should == 1
          TheDude.commands[/^hey$/].ask.should == 'what'
        end
      end

      context 'and a block answer' do
        it 'should register a new dude command' do
          TheDude::Dsl.new.command @question do
            'what'
          end
          TheDude.commands.length.should == 1
          TheDude.commands[/^hey$/].ask.should == 'what'
        end
      end
    end
  end

  describe '#var' do
    context 'when passed a variable name and regex' do
      it 'should register the variable with TheDude' do
        TheDude::Dsl.new.var :something, /cool/
        TheDude.variables.length.should == 1
        TheDude.variables[:something].pattern.should == /cool/
      end
    end
  end

  describe '.run' do
    context 'when passed a string' do
      before :each do
        TheDude::Dsl.run 'var :server, /\S+/'
      end

      it 'should execute the string' do
        TheDude.variables.length.should == 1
        TheDude.variables[:server].should be_kind_of TheDude::Variable
      end
    end

    context 'when passed a block' do
      before :each do
        TheDude::Dsl.run do
          var :server, /\S+/
        end
      end

      it 'should execute the block' do
        TheDude.variables.length.should == 1
        TheDude.variables[:server].should be_kind_of TheDude::Variable
      end
    end

    context 'when passed a string and a block' do
      before :each do
        TheDude::Dsl.run do
          var :server, /\S+/
        end
      end

      it 'should execute the block' do
        TheDude.variables.length.should == 1
        TheDude.variables[:server].should be_kind_of TheDude::Variable
      end
    end
  end
end
