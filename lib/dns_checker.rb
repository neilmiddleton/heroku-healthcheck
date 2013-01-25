module DnsChecker

  def check(app)
    domains = api.get_domains(app).body
    if domains.length > 0
      styled_header("Checking #{app} domains...\n\n")
      domains.collect{|d| check_domain(d) }
    else
      display("#{app} has no domain names.")
    end
  end

  def check_domain(domain)
    return if domain["domain"].match /.*.heroku(app).com/
    return if domain["domain"][0] == "*"
    res = Net::HTTP.get_response check_url(domain)
    parse_results JSON.parse(res.body)
  end

  def check_url(domain)
    URI("http://dnschecker.herokuapp.com/#{domain["domain"]}")
  end

  def parse_results(data)
    if data["state"] == "green"
      display("#{data["domain"]} - OK\n")
    elsif data["state"] == "amber"
      display("#{data["domain"]} - #{data["comments"]}\n")
    else
      display("#{data["domain"]} - WARNING - #{data["comments"]}\n")
    end
  end
end