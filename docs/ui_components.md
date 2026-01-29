# UI Components Guide

Discover the powerful, high-level UI components and utilities available in `kayo_package`. These widgets are designed to reduce boilerplate and ensure visual consistency.

## Components Catalog

### 1. TextView

An enhanced `Text` widget that accepts styling properties directly as parameters, reducing the nesting hell of `TextStyle` and `Container`.

```dart
TextView(
  'Featured Product',
  key: Key('product_title'),
  size: 16,
  color: Colors.black87,
  fontWeight: FontWeight.w600,
  // Layout constraints
  maxLine: 2,
  overflow: TextOverflow.ellipsis,
  // Container properties included!
  margin: EdgeInsets.symmetric(vertical: 8),
  padding: EdgeInsets.all(12),
  bgColor: Colors.grey[200],
  radius: 8,
  // Interaction
  onTap: () => print('Text tapped'),
)
```

### 2. ImageView

A unified image widget that automatically handles different sources (Asset, Network, File) and provides built-in placeholders and error states.

```dart
// Network Image with automatic caching
ImageView(
  url: 'https://example.com/cover.jpg',
  width: double.infinity,
  height: 200,
  radius: 12, // Rounded corners
  placeholder: 'assets/images/loading_placeholder.png',
  fit: BoxFit.cover,
)

// Local Asset Helper
ImageView(
  src: source('icons/home'), // Resolves to 'assets/icons/home.png'
  width: 24,
  height: 24,
  color: Colors.blue, // Tint capability
)
```

### 3. EditView

A pre-styled input field tailored for forms, with built-in support for cleaning icons, visibility toggles (for passwords), and layout margins.

```dart
EditView(
  controller: _emailController,
  hintText: 'Enter your email address',
  inputType: TextInputType.emailAddress,
  // Style
  textSize: 16,
  hintTextColor: Colors.grey,
  // Features
  showLine: true, // Shows an underline
  obscureText: false,
  margin: EdgeInsets.only(bottom: 16),
  // Actions
  onChanged: (value) => _validateEmail(value),
)
```

### 4. ToolBar

A highly customizable wrapper for the application top bar (AppBar).

```dart
ToolBar(
  title: 'Settings',
  // Customization
  backgroundColor: Colors.white,
  darkStatusText: true, // Forces status bar icons to be dark
  showBackBtn: true,
  // Actions
  actions: [
    IconButton(
      icon: Icon(Icons.save),
      onPressed: _saveSettings,
    )
  ],
  // The content of the page goes here (extends Scaffold behavior)
  child: SettingsContent(),
)
```

### 5. VisibleView

A cleaner way to handle widget visibility without using `if` statements in your widget tree or `Opacity` widgets.

```dart
VisibleView(
  visible: isLoading ? Visible.visible : Visible.gone,
  child: LoadingSpinner(),
)
```

- `Visible.visible`: Render the widget.
- `Visible.invisible`: Hide the widget but **maintain** its space (layout size).
- `Visible.gone`: Hide the widget and **remove** it from the layout (size 0).

---

## Utility Extensions

Make your code more readable with Dart extensions.

### Widget Extensions

Chain methods to wrap widgets without deeper indentation.

```dart
// Before
Container(
  padding: EdgeInsets.all(16),
  color: Colors.white,
  child: Text('Hello'),
)

// After
Text('Hello')
  .addContainer(padding: EdgeInsets.all(16), color: Colors.white)
  .setOnClick(onTap: () => print('Clicked'));
```

### Dark Mode Support

Easily adapt colors for light/dark themes.

```dart
// Returns the color in light mode, or the dark variant in dark mode
myColor.toDark(isDarkMode); 

// Usage in Widgets
Container(
  color: Colors.white.toDark(context.isDark),
)
```

## Dialog Utilities

Static helper methods for global interaction states.

> [!NOTE]
> Ensure you initialize the loading builder in `main.dart` for these to work correctly.

```dart
// Show a blocking loading spinner
LoadingUtils.show();

// Dismiss the loading spinner
LoadingUtils.dismiss();

// Show transient messages (Toast)
LoadingUtils.showToast(data: 'Operation completed');
LoadingUtils.showError(data: 'Something went wrong');
```
