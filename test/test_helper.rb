require 'vcr'
require 'minitest/autorun'
require 'rest_ejabberd'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/cassettes'
  c.default_cassette_options = { record: :once }
  c.hook_into :fakeweb
end
