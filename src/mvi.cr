require "webview"
require "markd"
require "clim"
require "fswatch"
require "common_marker"
require "front_matter"

require "./view"
require "./serve"

include View

module Mvi
  VERSION = "0.2.0"

  class Markdown

    def self.gen_temp_html(filepath)
      in_body_string = ""
      begin
        FrontMatter.open(filepath, false) do |front_matter, content_io|
          in_body_string = content_io.gets_to_end
        end
      rescue e
        in_body_string = File.read(filepath)
      end

      dir = File.dirname(filepath)

      extensions = ["table", "strikethrough", "autolink", "tagfilter", "tasklist"]
      options = ["unsafe"]

      md = CommonMarker.new(in_body_string, options: options, extensions: extensions)
      html = md.to_html
      html0 = {{ read_file "#{__DIR__}/../asset/theme1/template.html" }}
      html1 = html0.sub("\#{BODY}", html)

      File.open(dir+"/.temp.html", "w") do |file|
        file.print html1
      end
    end

    def killserver()

    end
  end



  class Cli < Clim

    main do
      desc "MVI. A simple markdown viewer."
      usage "mvi [options] [FILE]"
      version "Version #{Mvi::VERSION}"
      argument "file", type: String, desc: "Path to markfown file.", required: true

      run do |opts, args|

        print "#{args.file} !\n"
        if File.exists?(args.file)

          Mvi::Markdown.gen_temp_html(args.file)

          FSWatch.watch args.file do |event|
            if event.event_flag.to_s == "AttributeModified"
              Mvi::Markdown.gen_temp_html(args.file)
              p "reload file"
            end
          end

          filename = File.basename(args.file)
          directory  =  File.dirname(args.file)

          dir_listing = false

          fast_server = FastHttpServer.new directory, dir_listing
          server = HTTP::Server.new([HTTP::LogHandler.new, fast_server])
          server.bind_tcp "0.0.0.0", fast_server.port
          puts "FAST-HTTP-SERVER STARTED ON PORT #{fast_server.port}" + (directory == "./" ? "" : " at #{directory}")

          Thread.new do
            view(filename)
            #UGLY METHOD TO KILL SERVER
            GC.free(Pointer(Void).new(server.object_id))
            p server
          end

          server.listen

        end
      end
    end
  end

  Mvi::Cli.start(ARGV)

end
