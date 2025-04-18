import 'dart:ui' as ui;

import 'package:thumblr/thumblr.dart';

Future<ui.Image> extractVideoFrameAt({
  required String videoFilePath,
  required double positionInSeconds,
}) async {
  final thumbnail = await generateThumbnail(
    filePath: videoFilePath,
    position: positionInSeconds,
  );
  return thumbnail.image;
}
