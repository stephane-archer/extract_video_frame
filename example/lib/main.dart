import 'dart:ui' as ui;

import 'package:extract_video_frame/extract_video_frame.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

void showImageDialog({required BuildContext context, required ui.Image image}) {
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          content: RawImage(image: image),
          actions: [
            TextButton(
              child: Center(child: Text("Close")),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _positionInSeconds = 0.0;
  String? _videoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Extract a video frame"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  final path = result.files.single.path;
                  if (path != null) {
                    setState(() {
                      _videoPath = path;
                    });
                  }
                }
              },
              child: Text("Select Video File"),
            ),
            SizedBox(height: 10),
            if (_videoPath != null)
              Text(
                "Selected file:\n${_videoPath!.split('/').last}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            SizedBox(height: 30),
            Text(
              'Position in seconds: ${_positionInSeconds.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: _positionInSeconds,
              min: 0.0,
              max: 60.0,
              divisions: 600,
              label: _positionInSeconds.toStringAsFixed(2),
              onChanged: (value) {
                setState(() {
                  _positionInSeconds = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _videoPath == null
                      ? null
                      : () async {
                        final videoPath = _videoPath;
                        if (videoPath == null) {
                          return;
                        }
                        final image = await extractVideoFrameAt(
                          videoFilePath: _videoPath!,
                          positionInSeconds: _positionInSeconds,
                        );
                        if (context.mounted) {
                          showImageDialog(context: context, image: image);
                        }
                      },
              child: Text("Extract Frame"),
            ),
          ],
        ),
      ),
    );
  }
}
