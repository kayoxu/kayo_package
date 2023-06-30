import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';
import 'package:mpcore/mpkit/mpkit.dart';

class SwiperView extends StatefulWidget {
  final bool? autoplay;
  final bool? loop;
  final List<Widget>? children;
  final int? itemCount;
  final MPPageController? controller;
  final SwiperWidgetBuilder? itemBuilder;
  final int? initIndex;
  final bool? showIndicator;
  final bool? dotIndicator;

  SwiperView({Key? key,
    this.autoplay,
    this.loop,
    this.children,
    this.itemCount,
    this.controller,
    this.itemBuilder,
    this.initIndex,
    this.showIndicator,
    this.dotIndicator = true})
      : super(key: key);

  @override
  State<SwiperView> createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
  int activeIndex = 0;

  MPPageController? controller;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.initIndex ?? 0;
    controller =
        widget.controller ?? MPPageController(initialPage: activeIndex);
    controller?.addListener(() {
      setState(() {
        activeIndex = controller?.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemSize = widget.children?.length ?? widget.itemCount ?? 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        MPPageView(
          controller: controller,
          autoplay: widget.autoplay ?? false,
          loop: widget.loop ?? false,
          children: widget.children ??
              List.generate(
                  widget.itemCount ?? 0,
                      (index) =>
                  widget.itemBuilder?.call(context, index) ??
                      Container()),
        ),

        ...(widget.showIndicator == true ? [ Positioned(
            bottom: 10,
            child: (widget.dotIndicator ?? true) == true ? Row(
              children: List.generate(
                  itemSize, (index) {
                double space = 6;
                double size = 5;
                double activeSize = 5;
                var color = BaseColorUtils.colorBlackLiteLite;
                var activeColor = BaseColorUtils.colorAccent;
                var active = this.activeIndex == index;
                return Container(
                  key: Key("pagination_$index"),
                  margin: EdgeInsets.all(space),
                  child: ClipOval(
                    child: Container(
                      color: active ? activeColor : color,
                      width: active ? activeSize : size,
                      height: active ? activeSize : size,
                    ),
                  ),
                );
              }),
            ) : (itemSize == 0
                ? Container()
                : TextView('${activeIndex + 1} / ${itemSize}',
              size: 12,
              radius: 6,
              color: BaseColorUtils.colorWhite,
              bgColor: BaseColorUtils.colorBlackLiteLite.withOpacity(.3),
              padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),)))
        ] : [])

      ],
    );
  }
}

typedef SwiperWidgetBuilder = Widget? Function(BuildContext context, int index);

class SwiperItem {
  String? url;
  String? src;

  SwiperItem({
    this.url,
    this.src,
  });

  factory SwiperItem.fromJson(Map<String, dynamic> json) =>
      _$SwiperItemFromJson(json);

  Map<String, dynamic> toJson() => _$SwiperItemToJson(this);
}

SwiperItem _$SwiperItemFromJson(Map<String, dynamic> json) {
  return SwiperItem(
    url: json['url'] as String?,
    src: json['src'] as String?,
  );
}

Map<String, dynamic> _$SwiperItemToJson(SwiperItem instance) =>
    <String, dynamic>{
      'url': instance.url,
      'src': instance.src,
    };
