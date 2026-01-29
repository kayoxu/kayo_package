import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:kayo_package/kayo_package.dart';

// Helper function
String source(String src, {String suffix = '.png'}) {
  if (!src.contains("."))
    return 'assets/${KayoPackage.share.imageSourcePrefix}$src$suffix';
  return 'assets/${KayoPackage.share.imageSourcePrefix}$src';
}

/// Refactored ImageView
/// Cleaned up logic, removed legacy manual tap state handling, used InkWell.
class ImageView extends StatelessWidget {
  final String? base64Data;
  final String? src;
  final String? url;
  final String? heroTag;
  final bool useCache;
  final File? file;
  final double? width;
  final double? height;
  final double? rootWidth;
  final double? rootHeight;
  final ImageProvider? imageProvider;
  final BoxFit fit;
  final double radius;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets padding;

  final VoidCallback? onClick;
  final VoidCallback? onLongClick;
  final ValueChanged<String?>? onClickHero;

  final double? elevation;
  final Color? shadowColor;
  final double aspectRatio;
  final Color? bgColor;
  final EdgeInsets? imagePadding;
  final Color? imagePaddingColor;
  final double? imagePaddingRadius;
  final String? defaultImage;
  final bool? srcToFile;

  const ImageView({
    Key? key,
    this.src,
    this.base64Data,
    this.url,
    this.file,
    this.width,
    this.height,
    this.rootWidth,
    this.rootHeight,
    this.fit = BoxFit.fitHeight,
    this.radius = 0,
    this.color,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.onClick,
    this.onLongClick,
    this.elevation,
    this.shadowColor,
    this.bgColor,
    this.imagePadding,
    this.imagePaddingColor,
    this.imagePaddingRadius,
    this.defaultImage,
    this.aspectRatio = -1,
    this.useCache = false,
    this.imageProvider,
    this.srcToFile,
    this.onClickHero,
    this.heroTag,
  }) : super(key: key);

  String? get _heroTag {
    if (onClickHero != null) {
      return heroTag ??
          url ??
          src ??
          file?.path ??
          '${BaseSysUtils.randomColor().toARGB32()}';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = _buildImage(context);

    // Container wrapper
    Widget container = Container(
      height: rootHeight,
      width: rootWidth,
      color: bgColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: imageWidget,
      ),
    );

    // Aspect Ratio
    if (aspectRatio != -1) {
      container = AspectRatio(aspectRatio: aspectRatio, child: container);
    }

    // Image Padding wrapper
    if (imagePadding != null) {
      return Container(
        decoration: BoxDecoration(
          color: imagePaddingColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(imagePaddingRadius ?? 0),
        ),
        padding: imagePadding,
        alignment: Alignment.center,
        child:
            imageWidget, // Note: Original logic seemed to bypass container/aspect ratio here? checking closely.
        // Original: if imagePadding != null, it returns a Container with `child: image` (raw image).
        // If imagePadding == null, it returns Clickable wrapping `container2` (which is AspectRatio wrapping Container wrapping ClipRRect wrapping image).
        // Use container as child if appropriate? Original used `image`. I will stick to original logic but clean up.
      );
    }

    // Hero Wrapper
    Widget content = container;
    String? tag = _heroTag;
    if (onClickHero != null && tag != null && tag.isNotEmpty) {
      content = Hero(tag: tag, child: content);
    }

    // Clickable Wrapper
    if (onClick != null || onClickHero != null || onLongClick != null) {
      content = Padding(
        padding: margin,
        child: Material(
          color: Colors.transparent,
          elevation: elevation ?? 0,
          shadowColor: shadowColor ?? Colors.grey,
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: (onClick != null || onClickHero != null)
                ? () {
                    onClick?.call();
                    onClickHero?.call(tag);
                  }
                : null,
            onLongPress: onLongClick,
            // InkWell handles highlight/splash
            child: Padding(
              padding: padding,
              child: content,
            ),
          ),
        ),
      );
    } else {
      // If not clickable, just apply margin/padding/elevation if needed
      // Original applied shadow via Clickable even if not clickable?
      // Original: "Clickable" logic was: if onTap.. are null, return ShadowView...
      // If we want to preserve shadow, we can use Material.
      if (elevation != null && elevation! > 0) {
        content = Padding(
          padding: margin,
          child: Material(
            color: Colors.transparent,
            elevation: elevation!,
            shadowColor: shadowColor ?? Colors.grey,
            borderRadius: BorderRadius.circular(radius),
            child: Padding(padding: padding, child: content),
          ),
        );
      } else {
        // Just padding/margin
        content = Container(
          margin: margin,
          padding: padding,
          child: content,
        );
      }
    }

    return content;
  }

  Widget _buildImage(BuildContext context) {
    if (base64Data != null) {
      return Image.memory(
        base64.decode(base64Data!),
        height: height,
        width: width,
        fit: fit,
        gaplessPlayback: true,
      );
    }

    if (imageProvider != null) {
      return Image(
        image: imageProvider!,
        width: width,
        height: height,
        color: color,
        fit: fit,
      );
    }

    if (url != null && url!.isNotEmpty && url!.length > 10) {
      Widget placeholder = Image.asset(
        defaultImage ?? 'packages/kayo_package/assets/ic_no_data.png',
        height: height,
        width: width,
        fit: fit,
      );

      Widget errorWidget = Image.asset(
        defaultImage ?? 'packages/kayo_package/assets/ic_no_data.png',
        height: height,
        width: width,
        fit: fit,
      );

      if (useCache) {
        return CachedNetworkImage(
          imageUrl: url!,
          width: width,
          height: height,
          color: color,
          fit: fit,
          placeholder: (context, url) => placeholder,
          errorWidget: (context, url, error) => errorWidget,
          cacheManager: KayoPackage.share.ignoreSSL == true
              ? EsoImageCacheManager()
              : null,
        );
      } else {
        return FadeInImage.assetNetwork(
          placeholder:
              defaultImage ?? 'packages/kayo_package/assets/ic_no_data.png',
          image: url!,
          width: width,
          height: height,
          fit: fit,
          imageErrorBuilder: (ctx, err, stack) => errorWidget,
        );
      }
    }

    if (src != null && src!.isNotEmpty) {
      if (srcToFile == true) {
        return Image.file(
          File(src!),
          color: color,
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        return Image.asset(
          src!,
          color: color,
          width: width,
          height: height,
          fit: fit,
        );
      }
    }

    if (file != null) {
      return Image.file(
        file!,
        color: color,
        width: width,
        height: height,
        fit: fit,
      );
    }

    return Image.asset(
      defaultImage ?? 'packages/kayo_package/assets/ic_no_data.png',
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

class EsoImageCacheManager extends CacheManager {
  static const key = 'libEsoCachedImageData';
  static EsoImageCacheManager? _instance;

  factory EsoImageCacheManager() {
    _instance ??= EsoImageCacheManager._();
    return _instance!;
  }

  EsoImageCacheManager._()
      : super(Config(key, fileService: EsoHttpFileService()));
}

class EsoHttpFileService extends FileService {
  late HttpClient _httpClient;

  EsoHttpFileService({HttpClient? httpClient}) {
    _httpClient = httpClient ?? HttpClient();
    _httpClient.badCertificateCallback = (cert, host, port) => true;
  }

  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String>? headers}) async {
    final Uri resolved = Uri.base.resolve(url);
    final HttpClientRequest req = await _httpClient.getUrl(resolved);
    headers?.forEach((key, value) {
      req.headers.add(key, value);
    });
    final HttpClientResponse httpResponse = await req.close();
    final http.StreamedResponse response = http.StreamedResponse(
      httpResponse.timeout(const Duration(seconds: 60)),
      httpResponse.statusCode,
      contentLength: httpResponse.contentLength,
      reasonPhrase: httpResponse.reasonPhrase,
      isRedirect: httpResponse.isRedirect,
    );
    return HttpGetResponse(response);
  }
}
