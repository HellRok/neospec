require "local_ci"
require "standard/rake"

LocalCI::Rake.setup(self)

def run_on(commands:, image:, platform: "linux/amd64")
  run "docker run " \
    "--rm " \
    "--tty " \
    "--pull always " \
    "--workdir /app " \
    "--env BUNDLE_PATH=/gems/#{image.tr(":", "_")}/#{platform} " \
    "--env BUNDLE_WITHOUT=development " \
    "--mount type=bind,source=.,target=/app " \
    "--mount type=volume,source=neospec_gems,target=/gems/ " \
    "--platform #{platform} " \
    "#{image} " \
    "bash -c \"#{commands.join(" && ")}\""
end

flow "Linters" do
  job("StandardRB") { run "bundle exec standardrb" }
end

flow "MRI Ruby" do
  %w[4.0 3.4 3.3 3.2 3.1 3.0 2.7 2.6].each do |version|
    job("Ruby #{version}") do
      run_on(
        image: "ruby:#{version}",
        commands: [".ci/bin/test-ruby #{version}"]
      )
    end
  end
end

flow "JRuby" do
  %w[10 9].each do |version|
    job("JRuby #{version}") do
      run_on(
        image: "jruby:#{version}",
        commands: [".ci/bin/test-ruby #{version}"]
      )
    end
  end
end

flow "Taylor" do
  %w[v0.4.1 v0.4.0 v0.3.14.1 v0.3.13 v0.3.12.2].each do |version|
    job("Taylor #{version}") {
      run_on(
        image: "debian:latest",
        commands: [".ci/bin/test-taylor #{version}"]
      )
    }
  end
end
