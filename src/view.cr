module View

  def view(text)
    wv = Webview.window(640, 480, Webview::SizeHints::NONE, "Hello WebView", "http://localhost:3000/.temp.html")
    wv.run
    wv.destroy
  end

end
