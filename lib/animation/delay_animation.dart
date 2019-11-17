import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  DelayedAnimation({@required this.child, this.delay});
  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    final curve = CurvedAnimation(
      curve: Curves.easeIn,
      parent: _controller,
    );
    _animOffset = Tween<Offset>(begin: Offset(0.0, 0.35), end: Offset.zero)
        .animate(curve);
    if (widget.child == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FadeTransition(
        child: SlideTransition(
          position: _animOffset,
          child: widget.child,
        ),
        opacity: _controller,
      ),
    );
  }
}
