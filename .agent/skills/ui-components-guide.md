---
name: UI Components Guide
description: How to use kayo_package UI widgets
---
# UI Components Guide

## TextView

Enhanced text widget with styling shortcuts:

```dart
TextView(
  '文本内容',
  size: 14,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  margin: EdgeInsets.all(8),
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  alignment: Alignment.center,
  maxLine: 2,
  radius: 8,
  bgColor: Colors.blue,
  textAlign: TextAlign.center,
  textDarkOnlyOpacity: true,  // Only apply opacity in dark mode
  onTap: () {
    print('Tapped!');
  },
)
```

## ImageView

Unified image widget for assets, network, and file:

```dart
// Asset image
ImageView(
  src: source('home/ic_icon'),  // Uses source() helper
  width: 24,
  height: 24,
  fit: BoxFit.cover,
  radius: 12,
  color: Colors.grey,
  onClick: () {},
)

// Network image
ImageView(
  url: 'https://example.com/image.png',
  width: 100,
  height: 100,
  placeholder: 'assets/placeholder.png',
)

// With root dimensions (container size)
ImageView(
  src: source('logo'),
  rootWidth: 96,
  rootHeight: 96,
)
```

## EditView

Text input field:

```dart
EditView(
  controller: textController,
  hintText: '请输入内容',
  textSize: 14,
  textColor: Colors.black,
  hintTextColor: Colors.grey,
  hintTextSize: 13,
  showLine: false,         // Hide underline
  obscureText: true,       // Password mode
  margin: EdgeInsets.only(left: 16),
  keyboardType: TextInputType.email,
  inputFormatters: [
    LengthLimitingTextInputFormatter(11),
  ],
  focusNode: focusNode,
  onChanged: (value) {},
)
```

## ToolBar

Custom AppBar wrapper:

```dart
ToolBar(
  title: '页面标题',
  titleWidget: CustomWidget(),           // Custom title widget
  darkStatusText: true,                  // Dark status bar text
  backgroundColor: Colors.white,
  appbarColor: Colors.transparent,
  elevation: 0,
  showBackBtn: true,
  resizeToAvoidBottomPadding: false,
  actions: [
    IconButton(...)
  ],
  child: YourContent(),
)
```

## VisibleView

Visibility control with three modes:

```dart
enum Visible {
  visible,    // Show widget
  invisible,  // Hide but keep space
  gone,       // Hide and remove space
}

VisibleView(
  visible: condition ? Visible.visible : Visible.gone,
  child: YourWidget(),
)
```

## Widget Extensions

### Container Extension

```dart
widget.addContainer(
  color: Colors.white,
  margin: EdgeInsets.all(16),
  padding: EdgeInsets.all(8),
)
```

### Background Image

```dart
widget.addBgImg(src: source('login/ic_bg'))
```

### Click Handling

```dart
widget.setOnClick(
  onTap: () {},
  bgColor: Colors.transparent,
)
```

### Visibility

```dart
widget.setVisible2(visible: true)   // true = visible, false = gone
```

### Dark Mode Colors

```dart
color.dark              // Returns dark mode variant
color.darkNull          // Returns null for transparent in dark mode
ColorUtils.colorWhite.toDark(userDark: true)
```

## source() Helper

Helper function for asset paths:

```dart
// In your project, define:
String source(String name) => 'assets/$name.png';

// Usage:
ImageView(src: source('home/ic_menu'))  // -> 'assets/home/ic_menu.png'
```

## Dialog Utilities

### LoadingUtils

```dart
LoadingUtils.show();                    // Show loading spinner
LoadingUtils.dismiss();                 // Hide loading
LoadingUtils.showToast(data: 'Message');
LoadingUtils.showError(data: 'Error');
LoadingUtils.showInfo(data: 'Info');
LoadingUtils.showSuccess(data: 'Success');
```

### Builder Pattern

```dart
MaterialApp(
  builder: LoadingUtils.init(),  // Initialize loading overlay
)
```
