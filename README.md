# 🎞️ extract_video_frame

A Dart package for extracting a video frame at a specific timestamp with consistent behavior across platforms.

Currently supports **macOS** and **Windows**, more platforms coming soon (your contributions are welcome!).

## ✨ Features

- Extract a frame from a video file at any point in time.
- Returns a `ui.Image` for seamless use in Flutter apps.
- Consistent behavior across supported platforms.
- Clean and easy-to-use API.

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  extract_video_frame: ^<latest_version>
```
or run
```bash
flutter pub add extract_video_frame
```

Then run:
```bash
flutter pub get
```

## 🚀 Usage

```Dart
import 'package:extract_video_frame/extract_video_frame.dart';
import 'dart:ui' as ui;

Future<void> getFrame() async {
  final ui.Image frame = await extractVideoFrameAt(
    videoFilePath: '/path/to/video.mp4',
    positionInSeconds: 3.5, // Get frame at 3.5 seconds
  );
  // Use the frame as needed (e.g., convert to PNG, display in UI, etc.)
}
```

## 🖥️ Platform Support

- ✅ Windows
- ✅ macOS
- 🚧 Linux
- 🚧 iOS
- 🚧 Android
- 🚧 Web 

Want to see this work on more platforms? Contributions are very welcome!

## 🤝 Contributing

Got an idea? Found a bug? Want to help add platform or format support?

Feel free to open:
- Issues
- Feature requests
- Pull requests

Every bit helps make `extract_video_frame` more powerful and accessible!