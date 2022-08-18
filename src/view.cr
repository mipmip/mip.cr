module View

  def view(html)

    html = Markd.to_html(html)
    html0 = <<-HTML
        data:text/html,<!DOCTYPE html><html lang="en-US">
        <head>
        <title>Hello,World!</title>
        </head>
        <body>
              #{html}
        </body>
        </html>
      HTML

      wv = Webview.window(640, 480, Webview::SizeHints::NONE, "Hello WebView", html0)
      wv.run
      wv.destroy


  end

end
