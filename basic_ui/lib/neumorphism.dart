import 'package:basic_ui/widgets/my_drawer.dart';
import 'package:basic_ui/widgets/neumorph_button.dart';
import 'package:basic_ui/widgets/neumorph_button_tapped.dart';
import 'package:flutter/material.dart';

class Neumorphism extends StatefulWidget {
  const Neumorphism({super.key});

  @override
  State<Neumorphism> createState() => _NeumorphismState();
}

class _NeumorphismState extends State<Neumorphism> {
  List<bool> buttonPressed = [true, false, false, false];

  void _letsPress(int index) {
    setState(() {
      for (int i=0; i<buttonPressed.length; i++) {
        buttonPressed[i] = (i == index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: NeumorphButton(width: 200.0, height: 200.0, icon: Icons.apple_outlined, radius: 50.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(index: 0, icon: Icons.home),
                _buildButton(index: 1, icon: Icons.favorite),
                _buildButton(index: 2, icon: Icons.settings),
                _buildButton(index: 3, icon: Icons.person),
              ],
            ),
            const SizedBox(height: 50),
          ],
        )
      ),
    );
  }

  Widget _buildButton({
    required int index,
    required IconData icon,
    double width = 50.0,
    double height = 50.0,
    double radius = 100.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => _letsPress(index),
        child: buttonPressed[index]
            ? NeumorphButtonTapped(width: width, height: height, icon: icon, radius: radius)
            : NeumorphButton(width: width, height: height, icon: icon, radius: radius),
      ),
    );
  }
}