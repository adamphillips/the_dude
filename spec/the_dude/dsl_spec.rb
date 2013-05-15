require 'spec_helper'

describe TheDude::Dsl do
  class Anony
    include TheDude::Dsl
  end

  describe '#ask' do
    context 'when asked' do
      context 'and the command exists' do
        before :each do
          Anony.new.command 'hey', 'what'
        end
        it 'should perform the requested command' do
          Anony.new.ask('hey').should == 'what'
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
          Anony.new.command @question, 'what'
          TheDude.commands.length.should == 1
          TheDude.commands[/^hey$/].ask.should == 'what'
        end
      end

      context 'and a proc answer' do
        it 'should register a new dude command' do
          Anony.new.command @question, ->{'what'}
          TheDude.commands.length.should == 1
          TheDude.commands[/^hey$/].ask.should == 'what'
        end
      end

      context 'and a block answer' do
        it 'should register a new dude command' do
          Anony.new.command @question do
            'what'
          end
          TheDude.commands.length.should == 1
          TheDude.commands[/^hey$/].ask.should == 'what'
        end
      end
    end
  end
end
