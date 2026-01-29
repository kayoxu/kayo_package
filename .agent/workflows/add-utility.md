---
description: How to add a new utility class to kayo_package
---
# Add Utility Workflow

Steps to add a new utility class to kayo_package.

## 1. Create utility file

Location: `lib/utils/<utility_name>_utils.dart`

Pattern: Static methods or singleton class

### Static Methods Pattern

```dart
/// Description of utility
class MyUtils {
  MyUtils._();  // Private constructor
  
  /// Method description
  static String format(String input) {
    return input.trim();
  }
  
  /// Check if value is valid
  static bool isValid(dynamic value) {
    return value != null && value.toString().isNotEmpty;
  }
}
```

### Singleton Pattern

```dart
/// Description of utility
class MyUtils {
  static MyUtils get share => MyUtils._share();
  static MyUtils? _instance;
  
  MyUtils._();
  
  factory MyUtils._share() {
    _instance ??= MyUtils._();
    return _instance!;
  }
  
  /// Instance method
  void doSomething() {
    // Implementation
  }
}
```

## 2. Export in index file

Add to `lib/utils/_index_utils.dart`:

```dart
export 'package:kayo_package/utils/<utility_name>_utils.dart';
```

## 3. Utility Guidelines

1. **Pure functions** when possible - no side effects
2. **Null safety** - handle null inputs gracefully
3. **Document all methods** with usage examples
4. **Group related methods** in same class
5. **Use descriptive names** - method names should be self-explanatory
