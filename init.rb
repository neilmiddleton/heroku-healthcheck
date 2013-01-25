require 'uri'
require 'json'
require_relative 'lib/dns_checker.rb'

class Heroku::Command::HealthCheck < Heroku::Command::Base

  # healthcheck
  #
  # displays a variety of information about your application that may indicate
  # any problems
  #
  def index
    validate_arguments!
    Heroku::Command::Status.new.index
    DnsChecker.new.check(app)
  end

end
