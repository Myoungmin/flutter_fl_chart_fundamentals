// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageData {
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  Uint16List? get image => throw _privateConstructorUsedError;
  Uint8List? get displayImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageDataCopyWith<ImageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDataCopyWith<$Res> {
  factory $ImageDataCopyWith(ImageData value, $Res Function(ImageData) then) =
      _$ImageDataCopyWithImpl<$Res, ImageData>;
  @useResult
  $Res call(
      {int width, int height, Uint16List? image, Uint8List? displayImage});
}

/// @nodoc
class _$ImageDataCopyWithImpl<$Res, $Val extends ImageData>
    implements $ImageDataCopyWith<$Res> {
  _$ImageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? image = freezed,
    Object? displayImage = freezed,
  }) {
    return _then(_value.copyWith(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint16List?,
      displayImage: freezed == displayImage
          ? _value.displayImage
          : displayImage // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageDataImplCopyWith<$Res>
    implements $ImageDataCopyWith<$Res> {
  factory _$$ImageDataImplCopyWith(
          _$ImageDataImpl value, $Res Function(_$ImageDataImpl) then) =
      __$$ImageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int width, int height, Uint16List? image, Uint8List? displayImage});
}

/// @nodoc
class __$$ImageDataImplCopyWithImpl<$Res>
    extends _$ImageDataCopyWithImpl<$Res, _$ImageDataImpl>
    implements _$$ImageDataImplCopyWith<$Res> {
  __$$ImageDataImplCopyWithImpl(
      _$ImageDataImpl _value, $Res Function(_$ImageDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? image = freezed,
    Object? displayImage = freezed,
  }) {
    return _then(_$ImageDataImpl(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint16List?,
      displayImage: freezed == displayImage
          ? _value.displayImage
          : displayImage // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$ImageDataImpl implements _ImageData {
  const _$ImageDataImpl(
      {required this.width,
      required this.height,
      this.image,
      this.displayImage});

  @override
  final int width;
  @override
  final int height;
  @override
  final Uint16List? image;
  @override
  final Uint8List? displayImage;

  @override
  String toString() {
    return 'ImageData(width: $width, height: $height, image: $image, displayImage: $displayImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDataImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality()
                .equals(other.displayImage, displayImage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      width,
      height,
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(displayImage));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDataImplCopyWith<_$ImageDataImpl> get copyWith =>
      __$$ImageDataImplCopyWithImpl<_$ImageDataImpl>(this, _$identity);
}

abstract class _ImageData implements ImageData {
  const factory _ImageData(
      {required final int width,
      required final int height,
      final Uint16List? image,
      final Uint8List? displayImage}) = _$ImageDataImpl;

  @override
  int get width;
  @override
  int get height;
  @override
  Uint16List? get image;
  @override
  Uint8List? get displayImage;
  @override
  @JsonKey(ignore: true)
  _$$ImageDataImplCopyWith<_$ImageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
