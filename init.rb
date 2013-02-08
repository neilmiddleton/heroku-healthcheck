$:.unshift File.expand_path("../lib", __FILE__)
require 'uri'
require 'net/http'
require 'dns_checker.rb'
require 'processes.rb'
require 'releases.rb'
require 'log_stats.rb'

class Heroku::Command::HealthCheck < Heroku::Command::Base
  include DnsChecker
  include Processes
  include Releases
  include LogStats

  # healthcheck
  #
  # displays a variety of information about your application that may indicate any problems
  #
  def index
    validate_arguments!

    Heroku::Command::Status.new.index
    display("")

    styled_header("Checking processes")
    get_processes(app)

    check_domains(app)
    display("")

    styled_header("Recent Releases")
    get_releases(app)
    display ""

    styled_header("Analyzing recent log entries")
    get_log_stats(app)
    display ""

  end

end
