require 'batoto_ripper'

require 'webmock/rspec'
require 'vcr'

require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
