require 'spec_helper'

describe TheDude::Expression do
  describe '#expression' do
    it 'should equal the original expression used to create the instance' do
      TheDude::Expression.new('something :cool').expression.should == 'something :cool'
      TheDude::Expression.new(/something :cool/).expression.should == /something :cool/
    end
  end

  describe '#to_regexp' do
    context 'when the expression is created with a string' do
      before :each do
        @expr = TheDude::Expression.new 'some expression'
        @expr.instance_variable_set(:@regexp, nil) # Clear out the cached regexp so that it gets rebuilt after we add variables
      end

      it 'should return a regex that exactly matches the string' do
        @expr.to_regexp.should == /^some\ expression$/
      end
    end

    context 'when the expression is created with a regex' do
      before :each do
        @expr = TheDude::Expression.new /a regex/
        @expr.instance_variable_set(:@regexp, nil) # Clear out the cached regexp so that it gets rebuilt after we add variables
      end

      it 'should return the regex' do
        @expr.to_regexp.should == /a regex/
      end
    end

    context 'when the expression is created with a regex containing a variable' do
      before :each do
        @expr = TheDude::Expression.new /a :placeholder regex/
        # @expr.instance_variable_set(:@regexp, nil) # Clear out the cached regexp so that it gets rebuilt after we add variables
      end

      context 'and the variable is not defined' do
        it 'should raise an error' do
          expect{@expr.to_regexp}.to raise_error TheDude::UndefinedVariableError
        end
      end

      context 'and the variable is defined' do
        before :each do
          TheDude::Variable.new(:placeholder, /\S+/).register
        end

        it 'should return the regex with the variable substituted' do
          @expr.to_regexp.should == /a (\S+) regex/
        end
      end
    end

    context 'when the expression is created with a regex containing multiple variables' do
      before :each do
        @expr = TheDude::Expression.new /a :multiple :placeholder regex/
      end

      context 'and neither variable is defined' do
        it 'should raise an error' do
          expect{@expr.to_regexp}.to raise_error TheDude::UndefinedVariableError
        end
      end

      context 'and only one variable is defined' do
        before :each do
          TheDude::Variable.new(:multiple, /\d+/).register
        end

        it 'should raise an error' do
          expect{@expr.to_regexp}.to raise_error TheDude::UndefinedVariableError
        end
      end

      context 'and both variables are defined' do
        before :each do
          TheDude::Variable.new(:multiple, /\d+/).register
          TheDude::Variable.new(:placeholder, /\S+/).register
        end

        it 'should return the regex with the variable substituted' do
          @expr.to_regexp.should == /a (\d+) (\S+) regex/
        end
      end
    end
  end
end
