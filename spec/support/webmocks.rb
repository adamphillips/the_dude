require 'uri'

# Globally accessible variable containing details of the mocked search
# requests. These are arranged by domain, term and page
#
# @example
#   @webmocks {
#     :www => {
#       'beast quest' => ['html for page 1', 'html for page 2']
#     }
#   }
@webmocks = {}

# Mocks the url for the specified domain and term. Additionally stores the
# details in @webmocks for use elsewhere
def mock_request url, body
  @webmocks[url] ||= {}
  @webmocks[url] = body

  #puts "registering #{url}"

  FakeWeb.register_uri :get, url, :body => body
end

# Load in the individual mocks
Dir[File.dirname(__FILE__) + '/webmocks/**/*.rb'].each {|f| require f}

mock_request 'https://www.google.co.uk', File.read('spec/support/webmocks/google2.html')

WEBMOCKS = @webmocks

