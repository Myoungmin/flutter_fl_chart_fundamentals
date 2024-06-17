import 'package:flutter/material.dart';
import 'package:flutter_fl_chart_fundamentals/src/view/base_view.dart';
import 'package:flutter_fl_chart_fundamentals/src/view/main/main_view_model.dart';
import 'package:flutter_fl_chart_fundamentals/theme/component/bar_chart_page.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModelProvider: mainViewModelProvider,
      builder: (ref, viewModel, state) => const Center(
        child: BarChartPage(),
      ),
    );
  }
}
