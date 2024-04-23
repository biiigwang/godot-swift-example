# Godot Swift GDExtension example
[中文版](README_ZH.md),[English](README.md)
## Introduction
In this example, reproduce the tutorial of the GodotSwift community: [`Meet SwiftGodot`](https://migueldeicaza.github.io/SwiftGodotDocs/tutorials/swiftgodot-tutorials/), tool version information:
- Godot 4.2.x
- Swift 5.10

## Features
- GDExtension plugin based on Swift
- Multi-platform exports
  - [x] Windows
  - [x] MacOS 

## How to use it
To use SwiftGodot, you need to compile our plugin as a dynamic library, and then declare our dynamic library to the Godot Editor.
I'll use `MacOS` as an example to illustrate that the development process for `Linux` and `Windows` platforms is similar.

### Compilation

Compile our plugins into `debug` and `release` versions, with the `debug` library for debugging and the `release` library for tracking game usage.
```bash
cd SimpleRunnerDriver
# Compile the Swift code in debug mode
# This mode is easy to debug, but it comes with a performance penalty
swift build -c debug
# Compile the Swift code in release mode
swift build -c release
```

### Install dynamic libraries and write with gdextension files
The compiled product is located in `SimpleRunnerDriver/.build/debug` and `SimpleRunnerDriver/.build/release`, and we need to use two dynamic libraries:
- `libSimpleRunnerDriver.dylib`: The plugin we actually wrote
- `libSwiftGodot.dylib`: The godot binding that our plugin depends on
The target location of the dynamic library needs to correspond to the writing of the gdextension file, please refer to the [documentation](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdextension/gdextension_cpp_example.html#using-the-gdextension-module) for more information about gdextension

Now we need to write the 'gdextension' file
In this example, only the dynamic libraries for 'Windows x86_64' and 'MacOS arm64' are actually used
> Note: The two libraries are processed on the Windows platform, and other *.dll under `C:{your_swift_install_dir}Swiftruntime-developmentusrbin*.dll` are also required
```gdextension
[configuration]
entry_symbol = "swift_entry_point"
compatibility_minimum = 4.2

[libraries]
macos.debug = "res://bin/arm64-apple-macosx-debug/libSimpleRunnerDriver.dylib"
macos.release = "res://bin/arm64-apple-macosx-release/libSimpleRunnerDriver.dylib"
windows.debug.x86_32 = "res://bin/MyFirstGame"
windows.release.x86_32 = "res://bin/MyFirstGame"
windows.debug.x86_64 = "res://bin/x86_64-windows-debug"
windows.release.x86_64 = "res://bin/x86_64-windows-release"
linux.debug.x86_64 = "res://bin/MyFirstGame"
linux.release.x86_64 = "res://bin/MyFirstGame"
linux.debug.arm64 = "res://bin/MyFirstGame"
linux.release.arm64 = "res://bin/MyFirstGame"
linux.debug.rv64 = "res://bin/MyFirstGame"
linux.release.rv64 = "res://bin/MyFirstGame"
android.debug.x86_64 = "res://bin/MyFirstGame"
android.release.x86_64 = "res://bin/MyFirstGame"
android.debug.arm64 = "res://bin/MyFirstGame"
android.release.arm64 = "res://bin/MyFirstGame"



[dependencies]
macos.debug = {"res://bin/arm64-apple-macosx-debug/libSwiftGodot.dylib" : ""}
macos.release = {"res://bin/arm64-apple-macosx-release/libSwiftGodot.dylib" : ""}
windows.debug.x86_64 = {"res://bin/x86_64-windows-debug/libSwiftGodot.dll" : ""}
windows.release.x86_64 = {"res://bin/x86_64-windows-release/libSwiftGodot.dll" : ""}
```
### Use extensions
At this point, we can go back to `Godot`, and when we add nodes, we can search for `MainLevel` and `PlayerController`