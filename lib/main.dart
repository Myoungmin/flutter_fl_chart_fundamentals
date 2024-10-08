import 'dart:math';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fl_chart_fundamentals/bar_chart_page_view_model.dart';
import 'package:flutter_fl_chart_fundamentals/image_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final histogramProvider = Provider<List<int>>((ref) {
//   final imageData = ref.watch(imageDataProvider);
//   if (imageData.image == null) {
//     return List<int>.filled(65536, 0);
//   }

//   return _calculateHistogram(imageData.image!);
// });

final histogramProvider = FutureProvider<List<int>>((ref) async {
  final imageData = ref.watch(imageDataProvider);
  if (imageData.image == null) {
    return List<int>.filled(65536, 0);
  }

  return await compute(_calculateHistogram, imageData.image!);
});

List<int> _calculateHistogram(Uint16List image) {
  List<int> histogram = List.filled(65536, 0);
  for (var value in image) {
    histogram[value]++;
  }
  return histogram;
}

class BarChartPage extends ConsumerStatefulWidget {
  const BarChartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BarChartPageState();
}

class BarChartPageState extends ConsumerState<BarChartPage> {
  double dragStart = 0;
  int oldStart = 0;
  double initialScale = 1.0;

  @override
  Widget build(BuildContext context) {
    ImageData imageData = ref.watch(imageDataProvider);
    BarChartPageViewModel viewModel = ref.watch(barChartPageViewModelProvider);
    int start = viewModel.start;
    double scale = viewModel.scale;
    int interval = scale.toInt() * 8;
    final histogramAsyncValue = ref.watch(histogramProvider);
    late List<int> histogram;

    return histogramAsyncValue.when(
      data: (result) {
        histogram = result;

        return Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double sliderWidth = 50; // 슬라이더의 너비
              double availableWidth = constraints.maxWidth - 100 - sliderWidth;
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Listener(
                          onPointerSignal: (event) {
                            if (event is PointerScrollEvent) {
                              // 마우스 포인터 위치
                              final localPosition = event.localPosition.dx;
                              // 차트에서의 상대 위치
                              final relativePosition =
                                  localPosition / availableWidth;
                              final currentStart =
                                  ref.read(barChartPageViewModelProvider).start;

                              double newScale = scale;
                              if (event.scrollDelta.dy > 0) {
                                newScale = scale * 1.1;
                              } else {
                                newScale = scale * 0.9;
                              }

                              // 현재 마우스 포인터가 가리키는 값
                              int currentPointer = currentStart +
                                  (viewModel.groupCount *
                                          relativePosition *
                                          scale)
                                      .toInt();

                              // 스케일 변경으로 마우스 포인터가 가리키는 값은 유지하기 위한 새로운 시작점
                              int newStart = currentPointer -
                                  (viewModel.groupCount *
                                          relativePosition *
                                          newScale)
                                      .toInt();

                              ref
                                  .read(barChartPageViewModelProvider.notifier)
                                  .setScale(newScale);
                              ref
                                  .read(barChartPageViewModelProvider.notifier)
                                  .setStart(newStart);
                            }
                          },
                          child: GestureDetector(
                            //behavior: HitTestBehavior.translucent,
                            onDoubleTap: () {
                              ref
                                  .read(barChartPageViewModelProvider.notifier)
                                  .setScale(256);
                              ref
                                  .read(barChartPageViewModelProvider.notifier)
                                  .setStart(0);
                            },
                            onScaleStart: (details) {
                              initialScale = viewModel.scale;
                              dragStart = details.focalPoint.dx;
                              oldStart =
                                  ref.read(barChartPageViewModelProvider).start;
                            },
                            onScaleUpdate: (details) {
                              // 두 손가락 이상인 경우 (스케일링)
                              if (details.pointerCount > 1) {
                                double newScale = (initialScale / details.scale)
                                    .clamp(0.1, 1000.0);

                                // 중심 좌표 계산
                                final focalPoint = details.localFocalPoint.dx;
                                final relativeFocalPoint =
                                    focalPoint / availableWidth;
                                final currentStart = ref
                                    .read(barChartPageViewModelProvider)
                                    .start;

                                int currentPointer = currentStart +
                                    (viewModel.groupCount *
                                            relativeFocalPoint *
                                            viewModel.scale)
                                        .toInt();
                                int newStart = currentPointer -
                                    (viewModel.groupCount *
                                            relativeFocalPoint *
                                            newScale)
                                        .toInt();

                                ref
                                    .read(
                                        barChartPageViewModelProvider.notifier)
                                    .setScale(newScale);
                                ref
                                    .read(
                                        barChartPageViewModelProvider.notifier)
                                    .setStart(newStart);
                              } else {
                                // 한 손가락인 경우 (팬)
                                double newStart = oldStart -
                                    (details.focalPoint.dx - dragStart) *
                                        viewModel.scale;
                                ref
                                    .read(
                                        barChartPageViewModelProvider.notifier)
                                    .setStart(newStart.toInt());
                              }
                            },
                            child: SizedBox(
                              width: availableWidth,
                              height: constraints.maxHeight - 50,
                              child: BarChart(
                                BarChartData(
                                  barGroups: _generateBarGroups(
                                    ref,
                                    imageData,
                                    availableWidth,
                                    histogram,
                                  ),
                                  titlesData: FlTitlesData(
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                        interval: interval.toDouble(),
                                        getTitlesWidget:
                                            (double value, TitleMeta meta) {
                                          const style = TextStyle(
                                            color: Color(0xff7589a2),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          );

                                          double pixelValue =
                                              start + value * scale.toInt();

                                          // interval에 맞춰 실제로 라벨이 표시될지 여부 확인
                                          if ((pixelValue - start) %
                                                  meta.appliedInterval !=
                                              0) {
                                            return Container();
                                          }

                                          String text;
                                          if (pixelValue >= 1000000) {
                                            text =
                                                '${(pixelValue / 1000000).toStringAsFixed(1)}M';
                                          } else if (pixelValue >= 1000) {
                                            text =
                                                '${(pixelValue / 1000).toStringAsFixed(1)}K';
                                          } else {
                                            text =
                                                pixelValue.toStringAsFixed(0);
                                          }

                                          return SideTitleWidget(
                                            axisSide: meta.axisSide,
                                            space: 4,
                                            child: Text(text, style: style),
                                          );
                                        },
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 40,
                                        showTitles: true,
                                        interval: 50,
                                        getTitlesWidget:
                                            (double value, TitleMeta meta) {
                                          const style = TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          );

                                          String text;
                                          if (value >= 1000000) {
                                            text =
                                                '${(value / 1000000).toStringAsFixed(3)}M';
                                          } else {
                                            text = value.toStringAsFixed(0);
                                          }

                                          return SideTitleWidget(
                                            axisSide: meta.axisSide,
                                            space: 4,
                                            child: Text(text, style: style),
                                          );
                                        },
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 88,
                                          getTitlesWidget:
                                              (double value, TitleMeta meta) {
                                            return const SizedBox.shrink();
                                          }),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 10,
                                          getTitlesWidget:
                                              (double value, TitleMeta meta) {
                                            return const SizedBox.shrink();
                                          }),
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(
                                      top:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                  gridData: const FlGridData(show: true),
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    handleBuiltInTouches: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                        int pixelValue =
                                            start + group.x * scale.toInt();
                                        return BarTooltipItem(
                                          'Count: ${rod.toY.toStringAsFixed(0)}\n Pixel Value: $pixelValue\n',
                                          const TextStyle(color: Colors.red),
                                        );
                                      },
                                    ),
                                    touchCallback: (FlTouchEvent event,
                                        BarTouchResponse? response) {
                                      if (response != null &&
                                          response.spot != null) {
                                        if (event is FlPanStartEvent) {
                                          dragStart = event.localPosition.dx;
                                          oldStart = ref
                                              .read(
                                                  barChartPageViewModelProvider)
                                              .start;
                                        } else if (event is FlPanUpdateEvent) {
                                          double newStart = oldStart -
                                              (event.localPosition.dx -
                                                      dragStart) *
                                                  scale;
                                          ref
                                              .read(
                                                  barChartPageViewModelProvider
                                                      .notifier)
                                              .setStart(newStart.toInt());
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SizedBox(
                            width: availableWidth,
                            child: RangeSlider(
                              min: viewModel.start.toDouble(),
                              max: viewModel.start +
                                  scale * viewModel.groupCount,
                              divisions: viewModel.groupCount,
                              values: RangeValues(
                                viewModel.interestStart.toDouble().clamp(
                                    viewModel.start.toDouble(),
                                    (viewModel.start +
                                            scale * viewModel.groupCount)
                                        .toDouble()),
                                viewModel.interestEnd.toDouble().clamp(
                                    viewModel.start.toDouble(),
                                    (viewModel.start +
                                            scale * viewModel.groupCount)
                                        .toDouble()),
                              ),
                              onChanged: (value) {
                                BarChartPageViewModelNotifier
                                    barChartPageViewModelNotifier = ref.read(
                                        barChartPageViewModelProvider.notifier);

                                double adjustedStart = value.start.clamp(
                                    viewModel.start.toDouble(),
                                    (viewModel.start +
                                            scale * viewModel.groupCount)
                                        .toDouble());
                                double adjustedEnd = value.end.clamp(
                                    viewModel.start.toDouble(),
                                    (viewModel.start +
                                            scale * viewModel.groupCount)
                                        .toDouble());

                                barChartPageViewModelNotifier
                                    .setInterestStart(adjustedStart.toInt());
                                barChartPageViewModelNotifier
                                    .setInterestEnd(adjustedEnd.toInt());
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: sliderWidth,
                    height: constraints.maxHeight,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                        value: 257 - viewModel.scale.toDouble(),
                        min: 1,
                        max: 256,
                        divisions: 255,
                        label: (257 - viewModel.scale).toInt().toString(),
                        onChanged: (double value) {
                          value = 257 - value;
                          ref
                              .read(barChartPageViewModelProvider.notifier)
                              .setScale(value);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }

  List<BarChartGroupData> _generateBarGroups(WidgetRef ref, ImageData data,
      double availableWidth, List<int> histogram) {
    BarChartPageViewModel viewModel = ref.watch(barChartPageViewModelProvider);
    int groupCount = viewModel.groupCount;
    int scale = viewModel.scale.toInt();
    int start = viewModel.start;
    int end = start + scale * groupCount;

    double spaceBetweenBars = 0.1;
    double totalSpace = (groupCount - 1) * spaceBetweenBars;
    double barWidth = (availableWidth - totalSpace) / groupCount;

    List<int> groupedHistogram = List.filled(groupCount, 0);
    for (int i = start; i < end; i++) {
      if ((i - start) % scale == 0) {
        int groupIndex = (i - start) ~/ scale;
        groupedHistogram[groupIndex] = histogram[i];
      }
    }

    int groupInterestStart = (viewModel.interestStart - start) ~/ scale;
    int groupInterestEnd = (viewModel.interestEnd - start) ~/ scale;

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < groupedHistogram.length; i++) {
      bool isHighlighted = (i >= groupInterestStart && i <= groupInterestEnd);

      barGroups.add(
        BarChartGroupData(
          x: i,
          barsSpace: spaceBetweenBars,
          barRods: [
            BarChartRodData(
              toY: groupedHistogram[i].toDouble(),
              color: isHighlighted ? Colors.blue : Colors.blue.withOpacity(0.3),
              width: barWidth,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}

ImageData generateFakeImageData(int width, int height) {
  Random random = Random();
  Uint16List imageData = Uint16List.fromList(
    List<int>.generate(width * height, (index) => random.nextInt(65536)),
  );

  return ImageData(
    width: width,
    height: height,
    image: imageData,
  );
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('fl_chart_fundamentals')),
          body: const BarChartPage(),
        ),
      ),
    ),
  );
}
