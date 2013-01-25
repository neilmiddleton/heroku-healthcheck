require 'uri'
require 'json'
require_relative 'lib/dns_checker.rb'

class Heroku::Command::HealthCheck < Heroku::Command::Base
  include DnsChecker

  # healthcheck
  #
  # displays a variety of information about your application that may indicate any problems
  #
  def index
    validate_arguments!
    Heroku::Command::Status.new.index
    display("")

    styled_header("Checking processes")
    Heroku::Command::Ps.send(:index)

    display("")
    check_domains(app)
  end

end
