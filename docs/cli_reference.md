# CLI Reference

Commands for generating Flutter projects, modules, plugins, and packages.

## Commands

### Generate App

Create a new Flutter application with AndroidX support.

```bash
flutter create --androidx xxapp
```

**Specify Languages:**
Default is Java (Android) and Objective-C (iOS). To specify Kotlin and Swift:

```bash
flutter create --androidx -i swift -a kotlin xxapp
```

### Generate Module

Create a Flutter module for integration into existing native apps.

```bash
flutter create --androidx -t module xxapp_module
```

### Generate Plugin

Create a Flutter plugin (Dart API + platform-specific code).

```bash
flutter create --androidx --template=plugin xxapp_plugin
```

### Generate Package

Create a pure Dart package.

```bash
flutter create --androidx --template=package kayo_package
```
