require "webview"
require "markd"
require "clim"
require "fswatch"
require "common_marker"
require "front_matter"

require "./view"
require "./serve"

include View

module Mip
  VERSION = "0.2.0"

  class Markdown

    def self.gen_temp_html(filepath, port)
      url = "http://localhost:#{port}/.temp.seed"
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
      seed = rand
      html0 = {{ read_file "#{__DIR__}/../asset/theme1/template.html" }}
      html1 = html0.sub("\#{BODY}", html).sub("\#{SEEDURL}", url).sub("\#{INITIALSEED}", seed)

      File.open(dir+"/.temp.html", "w") do |file|
        file.print html1
      end
      File.open(dir+"/.temp.seed", "w") do |file|
        file.print seed
      end
    end

    def self.cleanup(filepath, verbose)

      if verbose
        p "CLEANUP"
      end
      dir = File.dirname(filepath)
      File.delete(dir+"/.temp.html") if File.exists?(dir+"/.temp.html")
      File.delete(dir+"/.temp.html.seed") if File.exists?(dir+"/.temp.html.seed")
    end
  end

  class Cli < Clim

    main do
      desc "MiP. A fast markdown viewer."
      usage "mip [options] [FILE]"
      version "Version #{Mip::VERSION}"
      option "-v", "--verbose", type: Bool, desc: "Verbose."
      argument "file", type: String, desc: "Path to markfown file.", required: true

      run do |opts, args|

        print "#{args.file} !\n"
        if File.exists?(args.file)


          filename = File.basename(args.file)
          directory  =  File.dirname(args.file)
          dir_listing = false
          fast_server = FastHttpServer.new directory, dir_listing
          server = HTTP::Server.new([HTTP::LogHandler.new, fast_server])
          address = server.bind_unused_port

          Mip::Markdown.gen_temp_html(args.file, address.port)

          FSWatch.watch args.file do |event|
            if event.event_flag.to_s == "AttributeModified"
              Mip::Markdown.gen_temp_html(args.file, address.port)
              p "reload file"
            end
          end

          Thread.new do
            view(filename, address.port)
            Mip::Markdown.cleanup(args.file, opts.verbose)

            #UGLY METHOD TO KILL SERVER
            GC.free(Pointer(Void).new(server.object_id))
            p server
          end

          if opts.verbose
            puts "FAST-HTTP-SERVER STARTED ON PORT #{address.port}" + (directory == "./" ? "" : " at #{directory}")
          end
          server.listen
          Mip::Markdown.cleanup(args.file, opts.verbose)

        end
      end
    end
  end

  Mip::Cli.start(ARGV)

end
