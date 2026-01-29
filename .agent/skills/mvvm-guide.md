---
name: MVVM Framework Guide
description: How to use the MVVM components in kayo_package
---
# MVVM Framework Guide

## Overview

kayo_package provides a complete MVVM (Model-View-ViewModel) framework built on top of Provider.

## Components

### BaseViewModel

Base class for all ViewModels. Extends `ChangeNotifier` for reactive state management.

```dart
import 'package:kayo_package/kayo_package.dart';

class MyViewModel extends BaseViewModel {
  // State variables
  String _title = '';
  String get title => _title;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  @override
  void initState() {
    super.initState();
    // Called when ViewModel is initialized
    // Access context via this.context
  }
  
  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }
  
  // Business logic methods
  void updateTitle(String value) {
    _title = value;
    notifyListeners();  // Notify View to rebuild
  }
  
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Fetch data...
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      setError();  // Set error state
    }
  }
}
```

### ViewState

Built-in states for common UI patterns:

```dart
enum ViewState {
  idle,   // Normal state
  busy,   // Loading
  empty,  // No data
  error,  // Error occurred
}

// Usage in ViewModel
void loadData() {
  setBusy();  // viewState = ViewState.busy
  
  // After loading...
  if (data.isEmpty) {
    setEmpty();
  } else {
    setIdle();
  }
}

// Check state
if (model.isBusy) { ... }
if (model.isEmpty) { ... }
if (model.isError) { ... }
```

### BaseViewModelList<T>

For list pages with pagination:

```dart
class ItemListViewModel extends BaseViewModelList<ItemData> {
  @override
  int getPageSize() => 20;  // Items per page
  
  @override
  bool hasMore() => true;   // Has more pages
  
  @override
  loadData({
    int? pageIndex,
    ValueChanged<List<ItemData>>? onSuccess,
    ValueChanged<List<ItemData>>? onCache,
    ValueChanged<String>? onError,
  }) {
    HttpQuery.share.itemService.getList({
      'page': pageIndex,
      'limit': pageSize,
    }, onSuccess: (response) {
      onSuccess?.call(response?.data ?? []);
    }, onError: (err) {
      onError?.call(err);
    });
  }
  
  // Built-in methods:
  // - refresh()       : Reload from first page
  // - loadMore()      : Load next page
  // - data            : Current list items
  // - pageIndex       : Current page number
  // - pageSize        : Items per page
  // - refreshController: For pull-to-refresh
}
```

### ProviderWidget<T>

Wrapper widget that binds ViewModel to View:

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MyViewModel>(
      model: MyViewModel(),
      autoLoadData: true,   // Call loadData() on init
      autoInitState: true,  // Call initState() on init
      autoDispose: true,    // Dispose ViewModel on widget dispose
      onModelReady: (model) {
        // Called after model is ready
      },
      builder: (context, model, child) {
        return Scaffold(
          body: _buildBody(model),
        );
      },
    );
  }
  
  Widget _buildBody(MyViewModel model) {
    if (model.isBusy) {
      return Center(child: CircularProgressIndicator());
    }
    if (model.isEmpty) {
      return Center(child: Text('No data'));
    }
    return YourContent(data: model.data);
  }
}
```

### ProviderWidget2<A, B>

For pages that need two ViewModels:

```dart
ProviderWidget2<Model1, Model2>(
  model1: Model1(),
  model2: Model2(),
  builder: (context, model1, model2, child) {
    return YourWidget();
  },
)
```

## Best Practices

1. **Keep Views dumb** - Views should only render UI, no business logic
2. **ViewModel owns state** - All state and logic in ViewModel
3. **Use notifyListeners()** - Call after state changes
4. **Clean up in dispose()** - Cancel subscriptions, close controllers
5. **Access context via ViewModel** - Use `model.context` when needed

## File Structure

```
lib/page/<feature>/
├── <feature>_page.dart           # View (StatelessWidget)
└── <feature>_view_model.dart     # ViewModel
```
