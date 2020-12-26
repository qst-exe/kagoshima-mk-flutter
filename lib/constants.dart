import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants();

  factory Constants.of() {
    if (_instance != null) {
      return _instance;
    }

    return _instance;
  }

  static Constants _instance;

  static const String pageHome = '/home';
  static const String pageDetail = '/detail';

  static const String questionCollection = 'questions';
  static const String choiceCollection = 'choices';
}
