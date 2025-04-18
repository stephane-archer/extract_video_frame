import 'dart:io';
import 'dart:ui' as ui;

import 'package:thumblr/thumblr.dart';
import 'package:video_duration/video_duration.dart';

Future<ui.Image> extractVideoFrameAt({
  required String videoFilePath,
  required double positionInSeconds,
}) async {
  double position;
  if (Platform.isMacOS) {
    position = positionInSeconds;
  } else if (Platform.isWindows) {
    final videoDuration = await getVideoDuration(videoFilePath);
    position = positionInSeconds / videoDuration;
  } else {
    throw UnsupportedError(
      'extractVideoFrameAt is not supported on this platform',
    );
  }
  final thumbnail = await generateThumbnail(
    filePath: videoFilePath,
    position: position,
  );
  final image = thumbnail.image;
  if (Platform.isWindows) {
    return _forceOpaque(image);
  }
  return image;
}

Future<ui.Image> _forceOpaque(ui.Image original) async {
  // on Windows the extracted frame was transparent, this make it not transparent and fix the issue (thumblr 0.0.4)
  final byteData = await original.toByteData(
    format: ui.ImageByteFormat.rawRgba,
  );
  if (byteData == null) throw Exception("Failed to get image bytes");

  final pixels = byteData.buffer.asUint8List();

  // Only change alpha channel, preserve RGB
  for (var i = 0; i < pixels.length; i += 4) {
    pixels[i + 3] = 255;
  }

  final buffer = await ui.ImmutableBuffer.fromUint8List(pixels);
  final descriptor = ui.ImageDescriptor.raw(
    buffer,
    width: original.width,
    height: original.height,
    pixelFormat: ui.PixelFormat.rgba8888,
  );

  final codec = await descriptor.instantiateCodec();
  final frame = await codec.getNextFrame();
  return frame.image;
}
