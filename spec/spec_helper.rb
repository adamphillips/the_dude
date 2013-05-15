require 'the_dude'

require 'fakeweb'
require 'ostruct'

Dir["#{Dir.pwd}/spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before :each do
    # Reset the commands to avoid cross-test contamination
    TheDude.reset
  end
end
