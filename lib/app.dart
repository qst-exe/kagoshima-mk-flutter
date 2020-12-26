import 'package:flutter/material.dart';

import 'config/router.dart';
import 'ui/pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '鹿児島.mk 投票アプリ',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      onGenerateRoute: PageRouter.generate,
    );
  }
}
