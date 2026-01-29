# MVVM Framework Guide

`kayo_package` provides a robust **MVVM (Model-View-ViewModel)** framework designed for Flutter, built on top of the `provider` package. It enforces a clean separation of concerns, making your codebase scalable, testable, and maintainable.

## Architecture Overview

The framework separates your application into three distinct layers:

```mermaid
graph TD
    View[View (UI)] <-->|Binds| VM[ViewModel (State & Logic)]
    VM -->|Requests| Model[Data Layer (Services/Repository)]
    Model -->|Returns Data| VM
    VM -->|Notifies| View
```

1. **View**: The UI layer (Widgets). It observes the ViewModel and rebuilds when state changes.
2. **ViewModel**: Holds the state and business logic. It interacts with the Data Layer and notifies the View.
3. **Model/Data**: The data source (API, Database, etc.).

---

## Core Components

### 1. BaseViewModel

The foundation of your business logic. It extends `ChangeNotifier` to manage state and lifecycle events.

> [!TIP]
> Always extend `BaseViewModel` for your page ViewModels to get built-in state management and lifecycle hooks.

```dart
import 'package:kayo_package/kayo_package.dart';

class UserProfileViewModel extends BaseViewModel {
  // State variables
  UserProfile? _user;
  UserProfile? get user => _user;

  @override
  void initState() {
    super.initState();
    // Called when the ProviderWidget initializes
    loadUserData();
  }

  /// Example business logic method
  Future<void> loadUserData() async {
    setBusy(); // Sets state to ViewState.busy and notifies listeners
    
    try {
      // Simulate API call
      _user = await _userService.fetchProfile();
      setIdle(); // Sets state to ViewState.idle
    } catch (e) {
      setError(e, stackTrace: StackTrace.current); // Sets state to ViewState.error
    }
  }
}
```

### 2. ViewState

Built-in states handle common UI scenarios automatically.

| State | Description | Method to Set |
| :--- | :--- | :--- |
| `idle` | Normal content state | `setIdle()` |
| `busy` | Loading/Processing state | `setBusy()` |
| `empty` | No data available | `setEmpty()` |
| `error` | Operation failed | `setError()` |

**Usage in View:**

```dart
if (model.isBusy) return LoadingSpinner();
if (model.isError) return ErrorView();
if (model.isEmpty) return EmptyView();
return Content(data: model.data);
```

### 3. ProviderWidget

The bridge that connects your **View** and **ViewModel**. It handles the creation, initialization, and disposal of the ViewModel.

```dart
class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<UserProfileViewModel>(
      model: UserProfileViewModel(),
      // Optional: Automatically call loadData() on init
      autoLoadData: true, 
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Profile')),
          body: _buildBody(context, model),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, UserProfileViewModel model) {
    if (model.isBusy) {
      return Center(child: CircularProgressIndicator());
    }
    // ... handle other states
    return Text('Welcome, ${model.user?.name}');
  }
}
```

---

## Advance Usage

### BaseViewModelList&lt;T&gt;

Designed for paginated lists. It handles page indices, refreshing, and loading more automatically.

```dart
class ProductListViewModel extends BaseViewModelList<Product> {
  @override
  Future<List<Product>> loadData({int pageNum = 1}) async {
    // Implement your data fetching
    return await _api.getProducts(page: pageNum);
  }
  
  // Optional customizations
  @override
  int get pageSize => 20;
}
```

### ProviderWidget2

Use this when a View depends on **two** separate ViewModels.

```dart
ProviderWidget2<UserViewModel, CartViewModel>(
  model1: UserViewModel(),
  model2: CartViewModel(),
  builder: (context, userModel, cartModel, child) {
    return Text('${userModel.name} has ${cartModel.itemCount} items');
  },
);
```

---

## Best Practices

> [!IMPORTANT]
> **Keep Views "Dumb"**: Your Widgets should strictly render UI based on the ViewModel's state. Avoid putting business logic, complex calculations, or direct API calls in the UI code.

- **Context Access**: access `BuildContext` safely via `model.context`.
- **Granularity**: Create specific ViewModels for complex widgets, not just for whole pages.
- **Disposal**: Override `dispose()` in your ViewModel to cancel streams or controllers, though `ProviderWidget` handles the ViewModel disposal itself.
