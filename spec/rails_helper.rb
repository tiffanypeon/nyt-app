# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'
extend WebMock::API

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    stub_request(:get, "http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js").to_return(body: network_stub_response('newest_articles.json'))
  end
end

def network_stub_response(filename)
  File.new Rails.root.join('spec/stubbed_responses', filename)
end



