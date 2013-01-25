require 'uri'
require 'json'
require_relative 'lib/dns_checker.rb'

class Heroku::Command::HealthCheck < Heroku::Command::Base

  def index
    validate_arguments!
    Heroku::Command::Status.index
    DnsChecker.check(app)
  end

end
