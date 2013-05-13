require 'spec_helper'

describe TheDude::Variable do
  describe '#initialize' do
    context 'when passed a symbol and a regexp' do
      it 'should return a new instance of TheDude::Variable' do
        TheDude::Variable.new :var1, /\S+/
      end
    end

    describe '#register' do
      before :each do
        @var = TheDude::Variable.new :var1, /\S+/
        @var.register
      end

      describe 'TheDude.variables' do
        subject {TheDude.variables}
        its(:length) {should == 1}
      end

      describe 'TheDude.variables[:var1]' do
        subject {TheDude.variables[:var1]}
        it {should be_kind_of TheDude::Variable}
        its(:name) {should == :var1}
        its(:pattern) {should == /\S+/}
      end
    end
  end
end
