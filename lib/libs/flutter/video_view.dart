import 'package:flutter/widgets.dart';
import 'package:kayo_package/kayo_package.dart';
import 'package:mpcore/mpcore.dart';

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
          url: url ?? '',
          autoplay: true,
        ));
  }
}
