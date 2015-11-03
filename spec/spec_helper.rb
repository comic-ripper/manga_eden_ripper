require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'manga_eden_ripper'

require 'webmock/rspec'
require 'vcr'

require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
