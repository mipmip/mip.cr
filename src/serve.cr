require "http"
require "option_parser"

class FastHttpServer < HTTP::StaticFileHandler
  property port

  def initialize(@publicdir = "./", @directory_listing = true)
    super
  end

  def call(context)
    if context.request.path.not_nil!
      indexed_url = "." + context.request.path + "index.html"

      if File.exists? indexed_url
        redirect_to context, "index.html"
        return
      end
    end

    super
  end
end


