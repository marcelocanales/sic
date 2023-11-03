# SIC - Search In Context

`sic` is a simple shell function that enhances the search experience in the codebase by providing context lines around search hits. It relies on `ag` (The Silver Searcher), `fzf` for interactive search result selection, and `bat` for syntax highlighting and context display.

![alt text](demo.gif "SIC Demo")


## Prerequisites

To use `sic`, you must have the following tools installed:

- [`ag`](https://github.com/ggreer/the_silver_searcher) (The Silver Searcher)
- [`fzf`](https://github.com/junegunn/fzf) (A command-line fuzzy finder)
- [`bat`](https://github.com/sharkdp/bat) (A `cat` clone with syntax highlighting and Git integration)

## Installation

To install `sic`, clone this repository or copy the contents of `sic.sh` into your local system.

```sh
git clone https://github.com/marcelocanales/sic.git
```

Add the following line to your `.bashrc`, `.zshrc`, or equivalent configuration file:

```sh
source /path/to/sic.sh
```

Replace `/path/to/sic.sh` with the actual path to the `sic.sh` script.

## Usage

To search for a term in your codebase with context, simply use the `sic` command followed by your search query:

```sh
sic 'search-term'
```

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or pull requests, please submit them on the GitHub repository page.

## License

`sic` is released under the [GNU version 3 License](LICENSE).

