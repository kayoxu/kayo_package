---
name: kayo_package Library
description: Flutter UI toolkit and MVVM framework
---
# kayo_package

Flutter UI toolkit, utilities and MVVM framework for rapid app development.

## Installation

```yaml
dependencies:
  kayo_package:
    git:
      url: https://gitee.com/kayoxu/kayo_package.git
      ref: 'v3.22'
```

## Library Structure

```
lib/
├── kayo_package.dart        # Main export file
├── mvvm/                    # MVVM Framework
│   └── base/
│       ├── base_view_model.dart       # Base ViewModel class
│       ├── base_view_model_list.dart  # List ViewModel with pagination
│       ├── provider_widget.dart       # MVVM widget wrapper
│       └── base_view_model_refresh.dart
├── views/                   # UI Components
│   └── widget/
│       ├── base/            # Base widgets (TextView, ImageView, EditView)
│       ├── button/          # Button components
│       ├── dialog/          # Dialog components
│       └── ...
├── http/                    # HTTP utilities
│   ├── base_http_manager.dart
│   ├── base_api.dart
│   └── base_code.dart
├── utils/                   # Utility classes
│   ├── base_sys_utils.dart
│   ├── base_time_utils.dart
│   ├── platform_utils.dart
│   └── loading_utils.dart
├── extension/               # Dart extensions
│   ├── color_extension.dart
│   ├── widget_extension.dart
│   └── ...
└── ai/                      # AI chat components
```

## Quick Start

### Import

```dart
import 'package:kayo_package/kayo_package.dart';
```

### Initialize in main.dart

```dart
void main() {
  KayoPackage.share.init(
    enableDark: true,
    onTapToolbarBack: (context) {
      Navigator.pop(context);
    },
    reLoginCode: 401,
  );
  runApp(MyApp());
}
```

## Core Features

### MVVM Architecture

- `BaseViewModel` - State management with ChangeNotifier
- `BaseViewModelList<T>` - List data with pagination
- `ProviderWidget<T>` - Widget that binds ViewModel to View

### UI Components

- `TextView` - Text with styling shortcuts
- `ImageView` - Image from assets/network/file
- `EditView` - Text input field
- `ToolBar` - Custom AppBar
- Widget extensions for common patterns

### HTTP Layer

- `BaseHttpManager` - HTTP request handling
- `BaseAPI` - API host configuration
- Automatic error handling and caching

### Utilities

- `BaseSysUtils` - System utilities (empty check, validation)
- `BaseTimeUtils` - Date/time formatting
- `LoadingUtils` - Loading/Toast dialogs
- `PlatformUtils` - Platform detection
