import 'dart:math';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageInfoProvider =
    NotifierProvider<ImageInfoNotifier, ImageInfo>(ImageInfoNotifier.new);

class ImageInfoNotifier extends Notifier<ImageInfo> {
  @override
  ImageInfo build() {
    Random random = Random();
    Uint16List imageData = Uint16List.fromList(
      List<int>.generate(3082 * 3082, (index) => random.nextInt(65536)),
    );

    return ImageInfo(
      width: 3082,
      height: 3082,
      image: imageData,
    );
  }

  void setImageInfo(ImageInfo info) {
    state = info;
  }
}

class BarChartPage extends ConsumerWidget {
  const BarChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImageInfo imageInfo = ref.watch(imageInfoProvider);

    return Center(
      child: BarChart(
        BarChartData(
          barGroups: _generateBarGroups(imageInfo),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 10,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  );

                  String text;
                  if (value.toInt() % 10 != 0) {
                    text = '';
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
                  if (value.toInt() % 1000 != 0) {
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
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          gridData: const FlGridData(show: true),
          barTouchData: BarTouchData(enabled: true),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(ImageInfo info) {
    List<int> histogram = List.filled(65536, 0);

    if (info.image != null) {
      for (var value in info.image!) {
        histogram[value]++;
      }
    }

    List<int> groupedHistogram = List.filled(256, 0);
    for (int i = 0; i < 65536; i++) {
      groupedHistogram[i ~/ 256] += histogram[i];
    }

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < groupedHistogram.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: groupedHistogram[i].toDouble(),
              color: Colors.blue,
              width: 5,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}

ImageInfo generateFakeImageInfo(int width, int height) {
  Random random = Random();
  Uint16List imageData = Uint16List.fromList(
    List<int>.generate(width * height, (index) => random.nextInt(65536)),
  );

  return ImageInfo(
    width: width,
    height: height,
    image: imageData,
  );
}

class ImageInfo {
  int width;
  int height;
  Uint16List? image;

  ImageInfo({
    this.width = 0,
    this.height = 0,
    this.image,
  });
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
