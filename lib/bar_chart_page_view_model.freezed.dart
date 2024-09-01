// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bar_chart_page_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BarChartPageViewModel {
  int get start => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  int get groupCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BarChartPageViewModelCopyWith<BarChartPageViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarChartPageViewModelCopyWith<$Res> {
  factory $BarChartPageViewModelCopyWith(BarChartPageViewModel value,
          $Res Function(BarChartPageViewModel) then) =
      _$BarChartPageViewModelCopyWithImpl<$Res, BarChartPageViewModel>;
  @useResult
  $Res call({int start, double scale, int groupCount});
}

/// @nodoc
class _$BarChartPageViewModelCopyWithImpl<$Res,
        $Val extends BarChartPageViewModel>
    implements $BarChartPageViewModelCopyWith<$Res> {
  _$BarChartPageViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? scale = null,
    Object? groupCount = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      groupCount: null == groupCount
          ? _value.groupCount
          : groupCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarChartPageViewModelImplCopyWith<$Res>
    implements $BarChartPageViewModelCopyWith<$Res> {
  factory _$$BarChartPageViewModelImplCopyWith(
          _$BarChartPageViewModelImpl value,
          $Res Function(_$BarChartPageViewModelImpl) then) =
      __$$BarChartPageViewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int start, double scale, int groupCount});
}

/// @nodoc
class __$$BarChartPageViewModelImplCopyWithImpl<$Res>
    extends _$BarChartPageViewModelCopyWithImpl<$Res,
        _$BarChartPageViewModelImpl>
    implements _$$BarChartPageViewModelImplCopyWith<$Res> {
  __$$BarChartPageViewModelImplCopyWithImpl(_$BarChartPageViewModelImpl _value,
      $Res Function(_$BarChartPageViewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? scale = null,
    Object? groupCount = null,
  }) {
    return _then(_$BarChartPageViewModelImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      groupCount: null == groupCount
          ? _value.groupCount
          : groupCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BarChartPageViewModelImpl implements _BarChartPageViewModel {
  _$BarChartPageViewModelImpl(
      {this.start = 0, this.scale = 256, this.groupCount = 256});

  @override
  @JsonKey()
  final int start;
  @override
  @JsonKey()
  final double scale;
  @override
  @JsonKey()
  final int groupCount;

  @override
  String toString() {
    return 'BarChartPageViewModel(start: $start, scale: $scale, groupCount: $groupCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarChartPageViewModelImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.groupCount, groupCount) ||
                other.groupCount == groupCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, start, scale, groupCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BarChartPageViewModelImplCopyWith<_$BarChartPageViewModelImpl>
      get copyWith => __$$BarChartPageViewModelImplCopyWithImpl<
          _$BarChartPageViewModelImpl>(this, _$identity);
}

abstract class _BarChartPageViewModel implements BarChartPageViewModel {
  factory _BarChartPageViewModel(
      {final int start,
      final double scale,
      final int groupCount}) = _$BarChartPageViewModelImpl;

  @override
  int get start;
  @override
  double get scale;
  @override
  int get groupCount;
  @override
  @JsonKey(ignore: true)
  _$$BarChartPageViewModelImplCopyWith<_$BarChartPageViewModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
