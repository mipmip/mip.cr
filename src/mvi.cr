require "webview"
require "markd"
require "clim"

require "./view"
require "./serve"
require "common_marker"
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

          extensions = ["table", "strikethrough", "autolink", "tagfilter", "tasklist"]
          options = ["unsafe"]
          md = CommonMarker.new(content, options: options, extensions: extensions)
          html = md.to_html
          html0 = {{ read_file "#{__DIR__}/../asset/template.html" }}
          html1 = html0.sub("\#{BODY}", html)
          File.open("./.temp.html", "w") do |file|
              file.print html1
          end

          directory  = "./"
          dir_listing = true
          fast_server = FastHttpServer.new directory, dir_listing
          server = HTTP::Server.new([HTTP::LogHandler.new, fast_server])
          server.bind_tcp "0.0.0.0", fast_server.port
          puts "FAST-HTTP-SERVER STARTED ON PORT #{fast_server.port}" + (directory == "./" ? "" : " at #{directory}")

          Thread.new do
            view(content)
          end

          server.listen

        end
      end
    end
  end

  Mvi::Cli.start(ARGV)

end
