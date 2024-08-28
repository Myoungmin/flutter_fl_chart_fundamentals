import 'dart:math';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fl_chart_fundamentals/bar_chart_page_view_model.dart';
import 'package:flutter_fl_chart_fundamentals/image_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarChartPage extends ConsumerWidget {
  const BarChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImageData imageData = ref.watch(imageDataProvider);
    int groupSize = ref.read(barChartPageViewModelProvider.notifier).groupSize;

    List<int> histogram = List.filled(65536, 0);

    for (var value in imageData.image!) {
      histogram[value]++;
    }

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double availableWidth = constraints.maxWidth - 100;
          return Listener(
            onPointerSignal: (event) {
              if (event is PointerScrollEvent) {
                if (event.scrollDelta.dy > 0) {
                } else {}
              }
            },
            child: GestureDetector(
              onDoubleTap: () {},
              child: SizedBox(
                width: availableWidth,
                height: constraints.maxHeight,
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
                          interval: 2048,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            );

                            String text;
                            int groupValue = value.toInt() * groupSize;
                            if (groupValue % 100 != 0) {
                              text = '';
                            } else if (groupValue >= 1000) {
                              text =
                                  '${(groupValue / 1000).toStringAsFixed(0)}K';
                            } else {
                              text = groupValue.toString();
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
                          interval: 1000,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            );

                            String text;
                            if (value.toInt() % 100 != 0) {
                              text = '';
                            } else if (value >= 1000000) {
                              text = '${(value / 1000000).toStringAsFixed(0)}M';
                            } else if (value >= 1000) {
                              text = '${(value / 1000).toStringAsFixed(0)}K';
                            } else {
                              text = value.toInt().toString();
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
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return const SizedBox.shrink();
                            }),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return const SizedBox.shrink();
                            }),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        top: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    gridData: const FlGridData(show: true),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            'Count: ${rod.toY.toStringAsFixed(0)}\n Pixel Value: ${group.x * groupSize}\n',
                            const TextStyle(color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(WidgetRef ref, ImageData data,
      double availableWidth, List<int> histogram) {
    BarChartPageViewModel viewModel = ref.watch(barChartPageViewModelProvider);
    int groupCount = viewModel.groupCount;
    int start = viewModel.start;
    int end = viewModel.end;
    int groupSize = ref.read(barChartPageViewModelProvider.notifier).groupSize;

    double spaceBetweenBars = 0.1;
    double totalSpace = (groupCount - 1) * spaceBetweenBars;
    double barWidth = (availableWidth - totalSpace) / groupCount;

    List<int> groupedHistogram = List.filled(groupCount, 0);
    for (int i = start; i < end; i++) {
      int groupIndex = (i - start) ~/ groupSize;
      groupedHistogram[groupIndex] += histogram[i];
    }

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < groupedHistogram.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barsSpace: spaceBetweenBars,
          barRods: [
            BarChartRodData(
              toY: groupedHistogram[i].toDouble(),
              color: Colors.blue,
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
