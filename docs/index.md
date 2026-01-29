# kayo_package

**A robust Flutter UI toolkit, MVVM framework, and utility collection.**

This package is designed to accelerate Flutter application development by providing a solid architectural foundation and a suite of reusable high-level components.

## 📚 Documentation

Detailed documentation is available in the `docs/` folder:

- [**MVVM Architecture**](mvvm.md)
  <br>Learn how to structure your app using the Model-View-ViewModel pattern for clean state management.

- [**UI Components**](ui_components.md)
  <br>Explore the catalog of high-level widgets like `TextView`, `ImageView`, and `ToolBar`.

- [**HTTP Networking**](http.md)
  <br>Configure and use the robust networking layer with built-in interceptors and error handling.

- [**CLI Reference**](cli_reference.md)
  <br>Cheat sheet for Quick Flutter project generation.

## 🚀 Quick Start

### 1. Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  kayo_package:
    git:
      url: https://gitee.com/kayoxu/kayo_package.git
      ref: 'v3.22'
```

### 2. Initialization

Initialize the package in your `main.dart` to set up global configurations like themes and error handlers.

```dart
import 'package:kayo_package/kayo_package.dart';

void main() {
  KayoPackage.share.init(
    enableDark: true, // Enable dark mode support
    reLoginCode: 401, // Error code that triggers re-login
    onTapToolbarBack: (context) => Navigator.pop(context),
  );
  
  runApp(MyApp());
}
```

## ✨ Key Features

- **MVVM Framework**: Built-in `BaseViewModel` and `ProviderWidget` simplify state management.
- **Smart Widgets**: `TextView` and `ImageView` reduce boilerplate code significantly.
- **Extensions**: Dozens of Dart extensions for `String`, `Color`, and `Widget`.
- **Utils**: Ready-to-use helpers for Validations, Date formatting, and Dialogs.

## License

MIT
