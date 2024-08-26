import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_chart_page_view_model.freezed.dart';

@freezed
class BarChartPageViewModel with _$BarChartPageViewModel {
  factory BarChartPageViewModel({
    @Default(0) int start,
    @Default(65535) int end,
    @Default(256) int groupCount,
  }) = _BarChartPageViewModel;
}

final barChartPageViewModelProvider =
    NotifierProvider<BarChartPageViewModelNotifier, BarChartPageViewModel>(
        BarChartPageViewModelNotifier.new);

class BarChartPageViewModelNotifier extends Notifier<BarChartPageViewModel> {
  int get range => state.end - state.start + 1;
  int get groupSize => range ~/ state.groupCount;

  @override
  BarChartPageViewModel build() {
    return BarChartPageViewModel();
  }

  void setRange(int start, int end) {
    start = start.clamp(0, 65535);
    end = end.clamp(0, 65535);
    if (start >= end) return;

    state = state.copyWith(start: start, end: end);
  }
}
