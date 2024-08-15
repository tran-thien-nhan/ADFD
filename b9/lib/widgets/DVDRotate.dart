import 'package:flutter/material.dart';

class DVDRotate extends StatefulWidget {
  final bool isRotating;
  const DVDRotate({super.key, required this.isRotating});

  @override
  State<DVDRotate> createState() => _DVDRotateState();
}

class _DVDRotateState extends State<DVDRotate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
  }

  @override
  void didUpdateWidget(covariant DVDRotate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRotating) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: (_controller),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: Image.network(
                "https://images2.thanhnien.vn/528068263637045248/2024/5/7/dam-vinh-hung-4-17150589400901672203078.jpg",
                width: 200,
                height: 200,
                fit: BoxFit.cover),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
