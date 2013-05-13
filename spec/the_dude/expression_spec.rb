require 'spec_helper'

describe TheDude::Expression do
  describe 'to_regex' do
    context 'when the expression is created with a string' do
      before :each do
        @expr = TheDude::Expression.new 'some expression'
      end

      it 'should return a regex that exactly matches the string' do
        @expr.to_regex.should == /^some\ expression$/
      end
    end

    context 'when the expression is created with a regex' do
      before :each do
        @expr = TheDude::Expression.new /a regex/
      end

      it 'should return the regex' do
        @expr.to_regex.should == /a regex/
      end
    end

    context 'when the expression is created with a regex containing a variable' do
      before :each do
        @expr = TheDude::Expression.new /a :placeholder regex/
      end

      context 'and the variable is not defined' do
        it 'should raise an error' do
          expect{@expr.to_regex}.to raise_error TheDude::UndefinedVariableError
        end
      end

      context 'and the variable is defined' do
        before :each do
          TheDude::Variable.new(:placeholder, /\S+/).register
        end

        it 'should return the regex with the variable substituted' do
          @expr.to_regex.should == /a (\S+) regex/
        end
      end
    end

    context 'when the expression is created with a regex containing multiple variables' do
      before :each do
        @expr = TheDude::Expression.new /a :multiple :placeholder regex/
      end

      context 'and neither variable is not defined' do
        it 'should raise an error' do
          expect{@expr.to_regex}.to raise_error TheDude::UndefinedVariableError
        end
      end

      context 'and only one variable is defined' do
        it 'should raise an error' do
          expect{@expr.to_regex}.to raise_error TheDude::UndefinedVariableError
        end
      end

      context 'and both variables are defined' do
        before :each do
          TheDude::Variable.new(:multiple, /\d+/).register
          TheDude::Variable.new(:placeholder, /\S+/).register
        end

        it 'should return the regex with the variable substituted' do
          @expr.to_regex.should == /a (\d+) (\S+) regex/
        end
      end
    end
  end
end
