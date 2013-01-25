module Releases

  def get_releases(app)
    validate_arguments!

    releases_data = api.get_releases(app).body.sort_by do |release|
      release["name"][1..-1].to_i
    end.reverse.slice(0, 5)

    unless releases_data.empty?
      releases = releases_data.map do |release|
        [
          release["name"],
          truncate(release["descr"], 40),
          release["user"],
          time_ago(release['created_at'])
        ]
      end

      styled_header("#{app} Releases")
      styled_array(releases, :sort => false)
    else
      display("#{app} has no releases.")
    end
  end

end
