require "webview"
require "markd"
require "clim"

require "./view"
include View

module Mvi
  VERSION = "0.1.0"

  class Cli < Clim

    main do
      desc "MVI. A simple markdown viewer."
      usage "mvi [options] [FILE]"
      version "Version #{Mvi::VERSION}"
      argument "file", type: String, desc: "Path to markfown file.", required: true

      run do |opts, args|
        print "#{args.file} !\n"
        if File.exists?(args.file)
          content = File.read(args.file)
          view(content)
        end
      end
    end
  end

  Mvi::Cli.start(ARGV)

end
