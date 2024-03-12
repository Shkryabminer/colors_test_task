import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final String _title = "Hello there";
  final int max = 255;
  static const int _animationDuration = 500;

  late AnimationController _animationController;
  late Animation _colorTween;

  late Color _beginColor;
  late Color _endColor;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _beginColor = Colors.white;
    _endColor = _getRandomColor();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: _animationDuration));
    _colorTween = ColorTween(begin: _beginColor, end: _endColor).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TapRegion(
      onTapInside: (pointDrawEvent) async {
        await _animationController.forward().whenComplete(() {
          setState(() {
            _animationController.reset();
            _beginColor = _endColor;
            _endColor = _getRandomColor();
            _colorTween = ColorTween(begin: _beginColor, end: _endColor).animate(_animationController);
          });
        });
      },
      child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) {
            return Container(
              color: _colorTween.value,
              child: Center(
                child: Text(_title),
              ),
            );
          }),
    ));
  }

  Color _getRandomColor() {
    var rnd = Random();
    var green = rnd.nextInt(max);
    var blue = rnd.nextInt(max);
    var red = rnd.nextInt(max);

    return Color.fromRGBO(red, green, blue, 1);
  }
}
