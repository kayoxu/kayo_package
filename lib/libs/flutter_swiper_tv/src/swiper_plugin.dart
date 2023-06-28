import 'package:flutter/widgets.dart';
import 'package:kayo_package/libs/flutter_page_indicator_tv/flutter_page_indicator.dart';
import 'package:kayo_package/libs/flutter_swiper_tv/src/swiper.dart';
import 'package:kayo_package/libs/flutter_swiper_tv/src/swiper_controller.dart';
import 'package:flutter/material.dart';
import 'package:mpcore/mpcore.dart';


/// plugin to display swiper components
///
abstract class SwiperPlugin {
  const SwiperPlugin();

  Widget build(BuildContext context, SwiperPluginConfig? config);
}

class SwiperPluginConfig {
  final int? activeIndex;
  final int? itemCount;
  final PageIndicatorLayout? indicatorLayout;
  final Axis scrollDirection;
  final bool? loop;
  final bool? outer;
  final MPPageController? pageController;
  final SwiperController controller;
  final SwiperLayout? layout;

  const SwiperPluginConfig(
      {this.activeIndex,
      this.itemCount,
      this.indicatorLayout,
      this.outer,
      required this.scrollDirection,
      required this.controller,
      this.pageController,
      this.layout,
      this.loop})
      : assert(scrollDirection != null),
        assert(controller != null);
}

class SwiperPluginView extends StatelessWidget {
  final SwiperPlugin plugin;
  final SwiperPluginConfig config;

  const SwiperPluginView(this.plugin, this.config);

  @override
  Widget build(BuildContext context) {
    return plugin.build(context, config);
  }
}
