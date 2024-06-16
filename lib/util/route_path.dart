import 'package:flutter/material.dart';
import 'package:flutter_fl_chart_fundamentals/src/view/main/main_view.dart';
import 'package:flutter_fl_chart_fundamentals/theme/component/constrained_screen.dart';

abstract class RoutePath {
  static const String main = 'main';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late final Widget page;
    switch (settings.name) {
      case RoutePath.main:
        page = const MainView();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => ConstrainedScreen(child: page),
    );
  }
}
