# Godot Swift GDExtension 示例
[中文版](README_ZH.md),[English](README.md)
## 简介
本例复刻`SwiftGodot`社区的教程:[`Meet SwiftGodot`](https://migueldeicaza.github.io/SwiftGodotDocs/tutorials/swiftgodot-tutorials/), 工具版本信息：
- Godot 4.2.x
- Swift 5.10

## 特性
- 基于Swift的GDExtension插件
- 多平台导出
  - [x] Windows
  - [x] MacOS 

## 怎么使用
使用`SwiftGodot`需要先编译我们的插件为动态库，再向`Godot Editor`声明我们的动态库。
我这里以`MacOS`为例进行说明，`Linux`,`Windows`平台的开发流程相似。

### 编译

将我们的插件编译为`debug`与`release`两种版本，`debug`库用于调试，`release`库用于追踪的游戏使用。
```bash
cd SimpleRunnerDriver
# Compile the Swift code in debug mode
# This mode is easy to debug, but it comes with a performance penalty
swift build -c debug
# Compile the Swift code in release mode
swift build -c release
```
### 安装动态库与gdextension文件编写
编译好的产物位于`SimpleRunnerDriver/.build/debug`与`SimpleRunnerDriver/.build/release`，我们需要使用的是两个动态库：
- `libSimpleRunnerDriver.dylib`：我们实际编写的插件
- `libSwiftGodot.dylib`：我们插件所依赖的godot绑定
动态库的目标位置需要与gdextension文件的编写相对应，关于gdextension的更多内容请参考该[文档](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdextension/gdextension_cpp_example.html#using-the-gdextension-module)。

现在我们需要编写`gdextension`文件
本例中只实际使用了`Windows x86_64`,`MacOS arm64`两个平台的动态库
> 注意：Windows平台下处理已上两个库，还需要`C:\{your_swift_install_dir}\Swift\runtime-development\usr\bin\*.dll`下其他*.dll

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
### 使用扩展
此刻我们就可以回到`Godot`,添加节点时可以搜索到`MainLevel`,`PlayerController`两个节点了