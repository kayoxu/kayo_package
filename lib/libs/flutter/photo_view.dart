import 'package:flutter/widgets.dart';
import 'package:kayo_package/libs/flutter/swiper.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';
import 'package:kayo_package/views/widget/base/image_view.dart';
import 'package:kayo_package/views/widget/base/text_view.dart';
import 'package:kayo_package/views/widget/tool_bar.dart';
import 'package:mpcore/mpkit/mpkit.dart';

class PhotoViewPage extends StatelessWidget {
  final List<String>? urls;
  final String? url;
  final String? title;
  final String fileHost;

  const PhotoViewPage(
      {Key? key, this.urls, this.url, this.title, required this.fileHost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> us = [];
    if (!BaseSysUtils.empty(urls)) {
      us.addAll(urls!);
    } else {
      if (!BaseSysUtils.empty(url)) {
        us.add(url!);
      }
    }

    us.remove('');

    return ToolBar(
        title: title ?? '查看图片',
        leadingIcon: MPIcon(MaterialIcons.close),
        child: Container(
          alignment: Alignment.center,
          color: BaseSysUtils.empty(us)
              ? BaseColorUtils.colorWindow
              : BaseColorUtils.colorBlack,
          child: BaseSysUtils.empty(us)
              ? TextView('暂无图片')
              : SwiperView(
                  autoplay: false,
                  dotIndicator: false,
                  loop: false,
                  showIndicator: us.length > 1,
                  itemCount: us.length,
                  itemBuilder: (context, index) {
                    var u = us[index];
                    return ImageView(
                      src: BaseSysUtils.getImageUrl(fileHost: fileHost, url: u),
                      fit: BoxFit.fitWidth,
                      // height: height,
                    );
                  },
                ),
        ));
  }
}
