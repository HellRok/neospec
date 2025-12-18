MRuby::Build.new do |conf|
  conf.toolchain

  conf.gembox "default"

  conf.gem github: "iij/mruby-env"
  conf.gem github: "iij/mruby-iijson"
  conf.gem github: "mattn/mruby-require"
end
