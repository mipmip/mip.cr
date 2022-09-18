module View

  def view(filename, port)
    url = "http://localhost:#{port}/.temp.html"

    wv = Webview.window(640, 480, Webview::SizeHints::NONE, "MiP - "+filename, url)

    wv.bind("reload", Webview::JSProc.new { |n|
      begin
        wv.navigate(url)
        JSON::Any.new("")
      rescue
        JSON::Any.new("")
      end

    })
    wv.run
    wv.destroy
  end

end
