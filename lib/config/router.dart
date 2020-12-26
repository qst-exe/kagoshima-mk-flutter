import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../ui/pages/detail.dart';
import '../ui/pages/home.dart';

mixin PageRouter implements StatelessWidget {
  static Route generate(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return PageTransition<Route>(
          child: HomePage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case '/detail':
        return PageTransition<Route>(
          child: DetailPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      default:
        throw StateError('不正なroutingです！');
    }
  }
}
