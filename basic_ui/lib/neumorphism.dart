import 'package:basic_ui/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class Neumorphism extends StatelessWidget {
  const Neumorphism({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(100)),
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
                  )
                ]
              ),
              child: Icon(
                Icons.handshake_outlined,
                size: 80,
                color: Colors.blue[300]
              ),
            ),
          ],
        )
      ),
    );
  }
}