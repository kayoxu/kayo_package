---
description: How to add a new extension to kayo_package
---
# Add Extension Workflow

Steps to add a new Dart extension to kayo_package.

## 1. Create extension file

Location: `lib/extension/<type>_extension.dart`

```dart
/// Extension for [TargetType]
extension MyExtension on TargetType {
  /// Description of method
  ReturnType myMethod() {
    // Implementation using 'this'
    return result;
  }
  
  /// Getter example
  bool get isValid => this != null;
}
```

## 2. Common Extension Patterns

### Widget Extension

```dart
extension WidgetExtension on Widget {
  /// Wrap widget in container with optional styling
  Widget addContainer({
    Color? color,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? radius,
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius != null 
            ? BorderRadius.circular(radius) 
            : null,
      ),
      child: this,
    );
  }
  
  /// Add click handler
  Widget setOnClick({
    VoidCallback? onTap,
    Color? bgColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}
```

### Color Extension

```dart
extension ColorExtension on Color {
  /// Get dark mode variant
  Color get dark {
    // Return darker version for dark mode
    return isDarkMode ? this.withBrightness(0.8) : this;
  }
}
```

### String Extension

```dart
extension StringExtension on String {
  /// Check if string is valid phone number
  bool get isPhoneNumber {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(this);
  }
  
  /// Check if string is valid email
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
}
```

## 3. Export in index file

Add to `lib/extension/_index_extension.dart`:

```dart
export 'package:kayo_package/extension/<type>_extension.dart';
```

## 4. Extension Guidelines

1. **Keep extensions focused** - one logical group per extension
2. **Use meaningful names** - extension and method names should be clear
3. **Document with examples** - show how to use the extension
4. **Avoid conflicts** - check for name collisions with other extensions
5. **Consider null safety** - use nullable extensions when appropriate

```dart
// Nullable extension
extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
```
