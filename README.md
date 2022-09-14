# Mvi

Mvi is a simple markdown viewer. Mvi uses a webview window to render the
markdown. I wrote to this preview my markdown files which I write in vim.

![](./markdown.png)

## Installation

- no releases yet. You should compile it yourself.

## Features

- built-in webserver
- preview images

## Todo

- autoreload
- respond to signals
- don't crash at reloat
- quit webview should quit application

## Usage

```
  MVI. A simple markdown viewer.

  Usage:

    mvi [options] [FILE]

  Options:

    --help                           Show this help.
    --version                        Show version.

  Arguments:

    01. file      Path to markfown file. [type:String] [required]

  Shortcuts:

    CTRL-r        Reload document
```


## Development

```bash
shards install
make build
./mvi
```

## Contributing

1. Fork it (<https://github.com/mipmip/mvi/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Pim Snel](https://github.com/mipmip) - creator and maintainer
