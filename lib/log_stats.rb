module LogStats

  def get_log_stats(app)
    @assigned_colors = {}
    @line_start = true
    @token = nil

    output = ""
    heroku.read_logs(app, ["num=10000", "ps=router"]) do |chunk|
      output = output + chunk unless chunk.empty?
    end
    errors = analyse_for_errors(output)
    display "Analyzing #{errors[:lines]} requests"
    render_count("H", errors[:h], errors[:lines])
    render_count("R", errors[:r], errors[:lines])
    render_count("L", errors[:l], errors[:lines])

  rescue Errno::EPIPE
  rescue Interrupt => interrupt
    if STDOUT.isatty && ENV.has_key?("TERM")
      display("\e[0m")
    end
    raise(interrupt)

  end

  def render_count(type, number, lines)
    percent = (number / 1.0) / lines * 100
    display("#{type} errors: #{number} (#{percent}%)")
  end

  def analyse_for_errors(output)
    errors = {}
    errors[:lines] = output.scan(/heroku\[router\]:/).size
    errors[:h] = output.scan(/.* code=H\d.*$/).size
    errors[:r] = output.scan(/.* code=R\d.*$/).size
    errors[:l] = output.scan(/.* code=L\d.*$/).size
    errors
  end

end
