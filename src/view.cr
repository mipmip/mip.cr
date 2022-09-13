module View

  def view(filename)
    wv = Webview.window(640, 480, Webview::SizeHints::NONE, "MVI - "+filename, "http://localhost:9391/.temp.html")
    wv.run
    wv.destroy
  end

end
