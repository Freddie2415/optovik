import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/simple_bloc_observer.dart';

import 'internal/application.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(Application());
}