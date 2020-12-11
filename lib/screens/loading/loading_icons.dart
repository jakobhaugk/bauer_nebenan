import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:delayed_display/delayed_display.dart';
import "dart:math" show pi, cos, sin, Random;

class _Icon extends StatelessWidget {
  final double size;
  final List<double> pos;
  final int index;

  _Icon({this.size, this.index, this.pos});

  @override
  Widget build(BuildContext context) => Animator(
      tween: Tween<double>(begin: 0.0, end: size),
      duration: Duration(milliseconds: 500),
      cycles: 0,
      curve: Curves.easeIn,
      triggerOnInit: true,
      builder: (context, anim, _) => SizedBox(
          width: anim.value,
          height: anim.value,
          child: Container(
              alignment: Alignment(pos[0], pos[1]),
              child: Image.asset(
                'assets/loading/icon ($index).png',
                width: this.size,
              ))));
}

// ignore: must_be_immutable
class LoadingIcons extends StatelessWidget {
  final int numberOfIcons, firstIconIndex, delayOffset, popInterval;
  final double iconSize, radius, derivation;
  List positions;

  LoadingIcons(
      {this.numberOfIcons,
      this.iconSize,
      this.radius = 0.5,
      this.derivation = 0.1,
      this.popInterval = 150,
      this.firstIconIndex,
      this.delayOffset = 500}) {
    var step = 2 * pi / this.numberOfIcons;
    this.positions = Iterable<int>.generate(numberOfIcons).map((n) {
      var rx = ((Random().nextInt(100) - 50) / 100) * this.derivation;
      var ry = ((Random().nextInt(100) - 50) / 100) * this.derivation;
      var x = this.radius * cos(step * (n + 1)) + rx;
      var y = this.radius * sin(step * (n + 1)) * 0.5 + ry;
      return [x, y];
    }).toList();
    this.positions.shuffle();
  }

  @override
  Widget build(BuildContext context) => Stack(
      children: this
          .positions
          .asMap()
          .entries
          .map((e) => Positioned.fill(
                child: DelayedDisplay(
                  slidingBeginOffset: Offset(0, 0),
                  delay: Duration(
                      milliseconds:
                          this.delayOffset + e.key * this.popInterval),
                  child: _Icon(
                      index: e.key + this.firstIconIndex,
                      size: this.iconSize,
                      pos: e.value),
                ),
              ))
          .toList());
}
