require 'uri'
require 'json'
require_relative 'lib/dns_checker.rb'
require_relative 'lib/processes.rb'
require_relative 'lib/releases.rb'
require_relative 'lib/log_stats.rb'

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
