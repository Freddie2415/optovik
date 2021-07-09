import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double strokeWidth;

  const LoadingWidget({Key key, this.strokeWidth = 4.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(strokeWidth: strokeWidth),
      ),
    );
  }
}
