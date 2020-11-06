import 'package:bekloh_user/component/circle_painter.dart';
import 'package:bekloh_user/component/current_wave.dart';
import 'dart:math' as math show sin, pi, sqrt;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatefulWidget {
  @override
  _RippleButtonState createState() => _RippleButtonState();
}

class _RippleButtonState extends State<RippleButton>  with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                Colors.red,
                Color.lerp(Colors.red, Colors.black, .05)
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve:  CurveWave(),
                ),
              ),
              child: Icon(Icons.directions_car, size: 44,)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        _controller,
        color: Colors.red,
      ),
      child: SizedBox(
        width: 80 * 4.125,
        height: 80 * 4.125,
        child: _button(),
      ),
    );
  }
}

