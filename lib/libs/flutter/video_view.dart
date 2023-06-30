import 'package:flutter/widgets.dart';
import 'package:kayo_package/utils/base_color_utils.dart';
import 'package:kayo_package/utils/base_sys_utils.dart';
import 'package:kayo_package/views/widget/tool_bar.dart';
import 'package:mpcore/mpkit/mpkit.dart';

class VideoViewPage extends StatelessWidget {
  final String? url;
  final String? title;
  final String fileHost;

  const VideoViewPage({Key? key, this.url, this.title, required this.fileHost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolBar(
        title: title ?? '查看视频',
        leadingIcon: MPIcon(MaterialIcons.close),
        backgroundColor: BaseColorUtils.colorBlack,
        child: MPVideoView(
          url: BaseSysUtils.getImageUrl(fileHost: fileHost, url: url),
          autoplay: true,
        ));
  }
}
