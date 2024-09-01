import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_chart_page_view_model.freezed.dart';

@freezed
class BarChartPageViewModel with _$BarChartPageViewModel {
  factory BarChartPageViewModel({
    @Default(0) int start,
    @Default(256) int scale,
    @Default(256) int groupCount,
  }) = _BarChartPageViewModel;
}

final barChartPageViewModelProvider =
    NotifierProvider<BarChartPageViewModelNotifier, BarChartPageViewModel>(
        BarChartPageViewModelNotifier.new);

class BarChartPageViewModelNotifier extends Notifier<BarChartPageViewModel> {
  int get range => state.scale * state.groupCount;

  @override
  BarChartPageViewModel build() {
    return BarChartPageViewModel(start: 256, scale: 255);
  }

  void setScale(int scale) {
    scale = scale.clamp(1, 256);
    state = state.copyWith(scale: scale);
  }

  void setStart(int start) {
    int max = 65536 - state.scale * state.groupCount;
    start = start.clamp(0, max);
    state = state.copyWith(start: start);
  }
}
