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
