require 'fakeweb'
require 'ostruct'

Dir["#{Dir.pwd}/spec/support/**/*.rb"].each {|f| require f}

include TestHelpers::Console

require 'the_dude'

RSpec.configure do |config|
  config.before :each do
    # Reset the commands to avoid cross-test contamination
    TheDude.reset
  end
end
