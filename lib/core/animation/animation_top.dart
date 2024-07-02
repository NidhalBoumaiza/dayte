import 'package:flutter/material.dart';

class AnimationTop extends StatefulWidget {
  final Widget child; // Widget to apply the animation to

  AnimationTop({required this.child});
  @override
  _AnimationTopState createState() => _AnimationTopState();
}

class _AnimationTopState extends State<AnimationTop>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, -1), // Start position (top of the screen)
      end: Offset(0, 0), // End position (original position)
    ).animate(_controller!);

    _controller?.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation!,
      child: widget.child, // Replace with your desired icon
    );
  }
}
