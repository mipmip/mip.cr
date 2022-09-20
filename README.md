# Markdown Instant Preview - MiP

Markdown Instant Preview aka `mip` is a fast and simple markdown viewer. Mip uses
a webview window to render the markdown. I wrote `mip` to this preview my markdown
files which I write in vim.

[mip-video.webm](https://user-images.githubusercontent.com/658612/191239184-6890c63c-7e72-4451-ba7c-12d38132bc5b.webm)

![](./markdown.png)

## Installation

- no releases yet. You should compile it yourself.

## Features

- built-in webserver
- preview images
- show/hide frontmatter
- autoreload if file changes

## Todo

- refactor code
- release workflow

## Usage

```
  mip. A simple markdown viewer.

  Usage:

    mip [options] [FILE]

  Options:

    --help                           Show this help.
    --version                        Show version.

  Arguments:

    01. file      Path to markfown file. [type:String] [required]

  Shortcuts:

    CTRL-r        Reload document
```


## Development

### Prerequisites

- crystal 1.x
- yarn
- make
- webkitgtk
- fswatch

### Setup Dev Environment

```bash
shards install
yarn
```

### Compile and run program

```bash
make
```

### Build optimized program

```bash
make build
./mip
```

### Compile themes

```bash
make build
./mip
```

## Contributing

1. Fork it (<https://github.com/mipmip/mip/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Pim Snel](https://github.com/mipmip) - creator and maintainer
