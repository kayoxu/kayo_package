# kayo_package

Flutter UI toolkit, utilities and MVVM framework for rapid app development.

## Features

- **MVVM Architecture** - `BaseViewModel`, `ProviderWidget` for clean separation of concerns
- **UI Components** - `TextView`, `ImageView`, `EditView`, `ToolBar` and more
- **HTTP Layer** - Structured API handling with caching and error management
- **Utilities** - Common functions for validation, formatting, loading dialogs
- **Extensions** - Widget, Color, String extensions for cleaner code

## Installation

```yaml
dependencies:
  kayo_package:
    git:
      url: https://gitee.com/kayoxu/kayo_package.git
      ref: 'v3.22'
```

## Documentation

See the [Documentation Directory](docs/index.md) for detailed guides:

- [**MVVM Guide**](docs/mvvm.md) - State management and architecture
- [**UI Components**](docs/ui_components.md) - Widget catalog and usage
- [**HTTP Guide**](docs/http.md) - Networking layer configuration
- [**CLI Reference**](docs/cli_reference.md) - Project generation commands

## Quick Start

```dart
import 'package:kayo_package/kayo_package.dart';

// Initialize in main.dart
void main() {
  KayoPackage.share.init(
    enableDark: true,
    onTapToolbarBack: (context) => Navigator.pop(context),
    reLoginCode: 401,
  );
  runApp(MyApp());
}

// Create a page with MVVM
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MyViewModel>(
      model: MyViewModel(),
      builder: (context, model, child) {
        return Scaffold(body: Text(model.title));
      },
    );
  }
}

class MyViewModel extends BaseViewModel {
  String title = 'Hello';
}
```

## License

MIT
