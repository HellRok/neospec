require "standard/rake"

task neospec: ["neospec:ruby", "neospec:taylor"]

task "neospec:ruby" do
  require "./spec/run"
end

task "neospec:taylor" do
  exec "taylor spec/run.rb"
end
