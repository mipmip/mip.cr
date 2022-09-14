module View

  def view(filename)
    url = "http://localhost:9391/.temp.html"
    wv = Webview.window(640, 480, Webview::SizeHints::NONE, "MVI - "+filename, url)

    wv.bind("reload", Webview::JSProc.new { |n|
      begin
        wv.navigate(url)
        p "oke"
        JSON::Any.new("")
      rescue
        p "??"
        JSON::Any.new("")
      end

    })
    wv.run
    wv.destroy
  end

end
