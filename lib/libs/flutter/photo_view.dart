import 'package:flutter/widgets.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:mpcore/mpcore.dart';

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
        child: SwiperView(
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
        ));
  }
}
