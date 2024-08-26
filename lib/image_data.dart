import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';

part 'image_data.freezed.dart';

@freezed
class ImageData with _$ImageData {
  const factory ImageData({
    required int width,
    required int height,
    Uint16List? image,
    Uint8List? displayImage,
  }) = _ImageData;
}

final imageDataProvider =
    NotifierProvider<ImageDataNotifier, ImageData>(ImageDataNotifier.new);

class ImageDataNotifier extends Notifier<ImageData> {
  @override
  ImageData build() {
    Random random = Random();
    Uint16List imageData = Uint16List.fromList(
      List<int>.generate(3082 * 3082, (index) => random.nextInt(65536)),
    );

    return ImageData(
      width: 3082,
      height: 3082,
      image: imageData,
    );
  }

  void setImageData(ImageData info) {
    state = info;
  }

  void windowLevel(int w1, int w2) {
    final image = state.image;
    final width = state.width;
    final height = state.height;

    if (w1 == w2) w2++;

    final windowRange = w2 - w1;
    const lutSize = 65536;
    final lutWindowLevel = Uint8List(lutSize);

    for (int rawValue = 0; rawValue < lutSize; rawValue++) {
      final rawValueInRange = max(w1, min(rawValue, w2));
      final byteVal = ((rawValueInRange - w1) * 255 ~/ windowRange);
      lutWindowLevel[rawValue] = byteVal;
    }

    final displayImage = Uint8List(width * height * 3);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final rawValue = image![y * width + x];
        final value = lutWindowLevel[rawValue];
        final index = (y * width + x) * 3;
        displayImage[index] = value;
        displayImage[index + 1] = value;
        displayImage[index + 2] = value;
      }
    }

    state = state.copyWith(displayImage: displayImage);
  }
}