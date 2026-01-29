---
description: How to add a new widget to kayo_package
---
# Add Widget Workflow

Steps to add a new reusable widget to kayo_package.

## 1. Create widget file

Location: `lib/views/widget/<category>/<widget_name>.dart`

```dart
import 'package:flutter/material.dart';

/// Widget description
///
/// Example usage:
/// ```dart
/// MyWidget(
///   title: 'Hello',
///   onTap: () {},
/// )
/// ```
class MyWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? radius;
  final Color? bgColor;
  
  const MyWidget({
    super.key,
    required this.title,
    this.onTap,
    this.margin,
    this.padding,
    this.radius,
    this.bgColor,
  });
  
  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius != null 
            ? BorderRadius.circular(radius!) 
            : null,
      ),
      child: Text(title),
    );
    
    if (onTap != null) {
      content = GestureDetector(
        onTap: onTap,
        child: content,
      );
    }
    
    return content;
  }
}
```

## 2. Export in index file

Add to `lib/views/widget/_index_widget.dart`:

```dart
export 'package:kayo_package/views/widget/<category>/<widget_name>.dart';
```

## 3. Document usage

Add examples in widget doc comment showing common use cases.

## Widget Design Guidelines

1. **Use const constructor** when possible
2. **Provide sensible defaults** for optional parameters
3. **Follow existing naming** - margin, padding, radius, bgColor
4. **Support dark mode** - use `.dark` color extension
5. **Keep widgets focused** - one responsibility per widget
6. **Add doc comments** with usage examples
