require 'spec_helper'

describe TheDude::Plugin do
  describe '#gem_name' do
    it 'should be the name of plugin prefixed with the_ruby-' do
      TheDude::Plugin.new('plugin').gem_name.should == 'the_dude-plugin'
    end
  end

  describe '.all' do
    subject {TheDude::Plugin.all}

    context 'when a gems are installed with the the_dude- prefix' do
      before :each do
        # Stub the call to Gem::Specification.latest_specs
        Gem::Specification.stub(:latest_specs).and_return([
          OpenStruct.new(name: 'the_dude-plugin'),
          OpenStruct.new(name: 'the_dude-plugin2'),
          OpenStruct.new(name: 'other-gem')
        ])
      end

      its(:length) {should == 2}

      describe '[0]' do
        subject {TheDude::Plugin.all[0]}

        it {should be_kind_of TheDude::Plugin}
        its(:name) {should == 'plugin'}
      end

      describe '[1]' do
        subject {TheDude::Plugin.all[1]}

        it {should be_kind_of TheDude::Plugin}
        its(:name) {should == 'plugin2'}
      end
    end
  end
end
