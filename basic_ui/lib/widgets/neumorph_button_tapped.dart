import 'package:flutter/material.dart';

class NeumorphButtonTapped extends StatelessWidget{
  final double width;
  final double height;
  final IconData icon;
  final double radius;

  const NeumorphButtonTapped({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          // for shadow effect
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.inversePrimary,
              offset: Offset(5.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: theme.colorScheme.secondary,
              offset: Offset(-5.0, -5.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
          // for inner shadow effect
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade700,
                Colors.grey.shade600,
                Colors.grey.shade500,
                Colors.grey.shade200,
              ],
              // where the each gradient will stop
              stops: [
                0,
                0.1,
                0.3,
                1
              ]
          )
      ),
      child: Icon(
          icon,
          size: width/2,
          color: Colors.grey[800]
      ),
    );
  }

}