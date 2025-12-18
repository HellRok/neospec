require "local_ci"
require "standard/rake"

LocalCI::Rake.setup(self)

def build_ci_docker_image
  job("Build CI Docker image") do
    run "docker build .ci " \
      "--pull " \
      "--file .ci/ci.dockerfile " \
      "--platform linux/amd64 " \
      "--tag local-ci:latest"
    run_asdf
    exec_in_asdf(".ci/bin/setup-env", root: true)
    exec_in_asdf(".ci/bin/setup-ruby")
  end
end

def stop_ci_docker
  job("Stop docker") {
    run "docker kill local-ci-neospec-asdf"
  }
end

def run_for(image, platform: "linux/amd64")
  run "docker run " \
    "--tty " \
    "--workdir /app " \
    "--mount type=bind,source=.,target=/app " \
    "--platform #{platform} " \
    "#{image} " \
    "ruby spec/run.rb"
end

def run_asdf
  run "docker run " \
    "--tty " \
    "--rm " \
    "--workdir /app " \
    "--mount type=bind,source=.,target=/app " \
    "--mount source=local_ci_neospec_asdf,target=/asdf/.asdf " \
    "--mount source=local_ci_neospec_taylor,target=/asdf/.taylor " \
    "--platform linux/amd64 " \
    "--detach " \
    "--name local-ci-neospec-asdf " \
    "local-ci " \
    "sleep infinity"
end

def exec_in_asdf(command, root: false)
  run "docker exec " \
    "--tty " \
    "#{"--user root " if root}" \
    "local-ci-neospec-asdf " \
    "#{command}"
end

setup do
  job("Bundle") { run "bundle check | bundle install" }
end

flow "Linters" do
  job("StandardRB") { run "bundle exec standardrb" }
end

flow "MRI Ruby - AMD64" do
  %w[4.0-rc 3.4 3.3 3.2 3.1 3.0 2.7 2.6].each do |version|
    job("Ruby #{version}") { run_for("ruby:#{version}") }
  end
end

flow "MRI Ruby - ARM64" do
  %w[4.0-rc 3.4 3.3 3.2 3.1 3.0 2.7 2.6].each do |version|
    job("Ruby #{version}") { run_for("ruby:#{version}", platform: "linux/arm64/v8") }
  end
end

flow "JRuby - AMD64" do
  %w[10 9].each do |version|
    job("JRuby #{version}") { run_for("jruby:#{version}") }
  end
end

flow "JRuby - ARM64" do
  %w[10 9].each do |version|
    job("JRuby #{version}") { run_for("jruby:#{version}", platform: "linux/arm64/v8") }
  end
end

flow "TruffleRuby" do
  setup { build_ci_docker_image }

  %w[25.0.0 24.2.1 23.1.2 22.3.1].each do |version|
    job("Truffle Ruby #{version}") {
      exec_in_asdf(".ci/bin/test-ruby truffleruby-#{version}")
    }
  end

  teardown { stop_ci_docker }
end

flow "TruffleRuby+GraalVM" do
  setup { build_ci_docker_image }

  %w[25.0.0 24.2.1 23.1.2 22.3.1].each do |version|
    job("Truffle Ruby #{version}") {
      exec_in_asdf(".ci/bin/test-ruby truffleruby+graalvm-#{version}")
    }
  end

  teardown { stop_ci_docker }
end

flow "MRuby" do
  setup { build_ci_docker_image }

  %w[3.4.0 3.3.0 3.2.0].each do |version|
    job("MRuby #{version}") {
      exec_in_asdf(".ci/bin/test-ruby mruby-#{version}")
    }
  end

  teardown { stop_ci_docker }
end

flow "Taylor" do
  setup { build_ci_docker_image }

  %w[v0.4.0 v0.3.14.1 v0.3.13 v0.3.12.2].each do |version|
    job("Taylor #{version}") {
      exec_in_asdf(".ci/bin/test-taylor #{version}")
    }
  end

  teardown { stop_ci_docker }
end
