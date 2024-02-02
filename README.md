# QML Eqlipse
<p><img src="https://img.shields.io/github/v/tag/0smr/eqlipse?sort=semver&label=version&labelColor=0bd&color=07b" alt="version tag">
<img src="https://img.shields.io/github/license/0smr/eqlipse?color=36b245" alt="license">
<a href="https://www.blockchain.com/bch/address/bitcoincash:qrnwtxsk79kv6mt2hv8zdxy3phkqpkmcxgjzqktwa3">
<img src="https://img.shields.io/badge/BCH-Donate-f0992e?logo=BitcoinCash&logoColor=f0992e" alt="BCH donate"></a></p>

**Eqlipse** QtQuick/QML theme (under development).

*If you liked these components, please consider givin a star :star2:.*

## How to use
> [!WARNING]
> Components in this repository are still in development, thus changes over each update may be significant.

### Usage

+ Clone the repository first.
    ```bash
    git clone "https://github.com/0smr/eqlipse.git"
    ```
+ Then add `eqlipse` to your makefile. <sub>[see example-1](example/example-1/CMakeLists.txt#L35)</sub>
    ```cmake
    add_subdirectory(/path/to/eqlipse/)
    target_link_libraries(my-target PRIVATE eqlipseplugin)
    ```
+ And finally import the `eqlipse` module. <sub>[see example-1](example/example-1/Root.qml#L5)</sub>
    ```qml
    import eqlipse
    ```

If you are confused, please refer to [example-1](example/example-1/) for a clearer understanding of what you should do.

## Components

- Button
- Dial
- Slider

## Issues

Please file an issue on [issues page](https://github.com/0smr/eqlipse/issues) if you have any problems.

## Documentation

[Documentation](docs/README.md) can be found in the `docs` directory.