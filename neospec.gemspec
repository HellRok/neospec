require_relative "lib/neospec/version"

Gem::Specification.new do |gem|
  gem.name = "neospec"
  gem.version = Neospec::VERSION
  gem.summary = "A simple testing library that works on ruby and mruby"
  gem.description = <<-DESC
    A simple testing library that works on ruby and mruby.

    This has been designed to be very modular, you can run different types of
    suites with different setup/teardown and before/after blocks. You can have
    as many reporters as you want, these can range from "output to the terminal
    in a nice way" all the way to "shape the results into an XML or JSON for my
    CI".

    The secondary purpose of this testing library is to work with mruby for my
    game engine Taylor and any project built upon that.

    I also plan to support quite a few ruby versions as I want the code for
    this to be very portable. The main feature I don't want to drop is
    positional AND keyword arguments in definitions, this means anything that
    matches the Ruby 2.6+ spec should be compatible.
  DESC
  gem.authors = ["Sean Earle"]
  gem.email = ["sean.r.earle@gmail.com"]
  gem.files = `git ls-files`.split($\)
  gem.homepage = "https://github.com/HellRok/neospec"
  gem.license = "MIT"
  gem.required_ruby_version = ">= 2.6.0"
end
