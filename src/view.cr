require "common_marker"
module View

  def view(text)

    extensions = ["table", "strikethrough", "autolink", "tagfilter", "tasklist"]
    options = ["unsafe"]
    md = CommonMarker.new(text, options: options, extensions: extensions)
    html = md.to_html
    p html

    html0 = {{ read_file "#{__DIR__}/../asset/template.html" }}
    html1 = "data:text/html,"+html0.sub("\#{BODY}", html)

    wv = Webview.window(640, 480, Webview::SizeHints::NONE, "Hello WebView", html1)
    wv.run
    wv.destroy

  end

end
