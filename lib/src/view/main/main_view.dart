import 'package:flutter/material.dart';
import 'package:flutter_fl_chart_fundamentals/src/service/theme_service.dart';
import 'package:flutter_fl_chart_fundamentals/src/view/base_view.dart';
import 'package:flutter_fl_chart_fundamentals/src/view/main/main_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModelProvider: mainViewModelProvider,
      builder: (ref, viewModel, state) => Center(
        child: Text(
          'Empty',
          style: ref.textTheme.titleLarge?.copyWith(
            color: ref.theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
