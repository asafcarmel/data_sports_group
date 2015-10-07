$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'data_sports_group/api'
require 'webmock/rspec'
require 'vcr'

def get_key
  ENV['DSG_KEY']
end

def get_client
  ENV['DSG_CLIENT']
end

def get_user
  ENV['DSG_USER']
end

def get_password
  CGI.escape(ENV['DSG_PASSWORD'])
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.preserve_exact_body_bytes { true }
  c.configure_rspec_metadata!

  ##
  # Filter the real API key so that it does not make its way into the VCR cassette

  c.filter_sensitive_data('<API_KEY>')     { get_key }
  c.filter_sensitive_data('<API_CLIENT>')  { get_client }
  c.filter_sensitive_data('<USER>')        { get_user }
  c.filter_sensitive_data('<PASS>')        { get_password }
end