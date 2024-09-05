import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_chart_page_view_model.freezed.dart';

@freezed
class BarChartPageViewModel with _$BarChartPageViewModel {
  factory BarChartPageViewModel({
    @Default(0) int start,
    @Default(256) double scale,
    @Default(256) int groupCount,
    @Default(16384) int interestStart,
    @Default(49152) int interestEnd,
  }) = _BarChartPageViewModel;
}

final barChartPageViewModelProvider =
    NotifierProvider<BarChartPageViewModelNotifier, BarChartPageViewModel>(
        BarChartPageViewModelNotifier.new);

class BarChartPageViewModelNotifier extends Notifier<BarChartPageViewModel> {
  int get range => state.scale.toInt() * state.groupCount;

  @override
  BarChartPageViewModel build() {
    return BarChartPageViewModel();
  }

  void setScale(double scale) {
    scale = scale.clamp(1, 256);

    int startMax = 65536 - scale.toInt() * state.groupCount;
    int adjustedStart = state.start.clamp(0, startMax);

    state = state.copyWith(start: adjustedStart, scale: scale);
  }

  void setStart(int start) {
    int max = 65536 - state.scale.toInt() * state.groupCount;
    start = start.clamp(0, max);
    state = state.copyWith(start: start);
  }

  void setInterestStart(int interestStart) {
    interestStart = interestStart.clamp(0, state.interestEnd - 1);
    state = state.copyWith(interestStart: interestStart);
  }

  void setInterestEnd(int interestEnd) {
    interestEnd = interestEnd.clamp(state.interestStart + 1, 65535);
    state = state.copyWith(interestEnd: interestEnd);
  }
}
