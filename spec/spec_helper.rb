require 'the_dude'

require 'fakeweb'
require 'support/webmocks'

RSpec.configure do |config|
  config.before :each do
    # Reset the commands to avoid cross-test contamination
    TheDude.reset
  end
end
