class ApplicationController < ActionController::Base
  config.generators do |g|
    g.test_framework :rspec,
                     fixtures: true,
                     view_specs: false,
                     helper_specs: false,
                     routing_specs: false,
                     controller_specs: false,
                     request_specs: false
    g.fixture_replacement :factory_bot, dir: "spec/factories"
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  # before_action :basic

  private
  # def basic
  #   authenticate_or_request_with_http_basic do |name, password|
  #     name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
  #   end
  # end
end
