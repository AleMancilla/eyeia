import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatefulWidget {
  @override
  _CustomLoadingWidgetState createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDot(0, context),
              SizedBox(width: 8),
              _buildDot(1, context),
              SizedBox(width: 8),
              _buildDot(2, context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    final dotSize = 16.0;
    final animation = Tween(begin: 0.0, end: 16.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          (index + 1) * 0.25,
          (index + 1) * 0.25 + 0.25,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: Colors.blue, // Color de los puntos de carga
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0),
          transform: Matrix4.translationValues(animation.value, 0, 0),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
