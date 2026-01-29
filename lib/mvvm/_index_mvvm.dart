import 'package:flutter/material.dart';
import 'base/provider_widget.dart';

export 'base/provider_widget.dart';
export 'base/base_view_model.dart';
export 'base/base_view_theme_bus_event.dart';
export 'base/base_view_model_list.dart';
export 'base/base_view_model_refresh.dart';

typedef BaseView<T extends ChangeNotifier> = ProviderWidget<T>;
