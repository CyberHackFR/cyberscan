<p align="center">
  <h1 align="center">CyberScan</h1>
  <h3 align="center">Automated attack surface mapper and vulnerability scanner</h3>
</p>



## What is this?

CyberScan is a high-performance and automated attack surface mapper and vulnerability scanner. Just point it to a target, and it will autimagically generate a report with everything it can finds, saving you hours of manual audit and pipping between different tools.


![Architecture]



## Installation

### Using cargo

```shell
$ cargo install -f cyberscan
```


### Using Docker



## Usage

```shell
# List modules
$ cyberscan modules
# Display scan options
$ cyberscan scan --help
# Scan a target
$ cyberscan scan --aggressive example.com
```


### With Docker


## License

See [`LICENSE.txt`](./LICENSE.txt).
