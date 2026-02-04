import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/button.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String inputValue = '';
  String outputValue = '';
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _inputScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _inputController.text = "";
    inputValue = '';
    outputValue = '';
  }

  void equalPressed() {
    String finalQuestion = inputValue;
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(finalQuestion);
    var context = ContextModel();
    var evaluator = RealEvaluator(context);
    num eval = evaluator.evaluate(exp);

    outputValue = eval.toString();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
                  child: TextField(
                    controller: _inputController,
                    scrollController: _inputScrollController,
                    readOnly: true,
                    showCursor: true,
                    decoration: InputDecoration(
                      labelText: 'Input',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: Theme.of(context).textTheme.bodyLarge,
                    onChanged: (value) {
                      setState(() {
                        inputValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: IgnorePointer(
                          child: TextField(
                            readOnly: true,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              labelText: 'Output',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            ),
                            controller: TextEditingController(text: outputValue),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: Button.buttonCount,
                itemBuilder: (context, index) {
                  final value = Button.buttonValues[index];
                  return AnimatedScaleButton(
                    value: value,
                    onTap: _onButtonTap,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonTap(String value) {

    setState(() {
      if (value == Button.del) {
        inputValue = inputValue.isNotEmpty ? inputValue.substring(0, inputValue.length - 1) : '';
      } else if (value == Button.clear) {
        inputValue = '';
        outputValue = '';
      } else if (value == Button.equal){
        value == '' ? '' : equalPressed();
      } else {
        inputValue += value;
      }

      _inputController.text = inputValue;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _inputScrollController.jumpTo(
          _inputScrollController.position.maxScrollExtent,
        );
      });
    });
  }
}

class AnimatedScaleButton extends StatefulWidget {
  final String value;
  final void Function(String) onTap;

  const AnimatedScaleButton({super.key, required this.value, required this.onTap});

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _scale = 1.0);
    widget.onTap(widget.value);
  }

  Color getButtonColor(String value) {
    return [Button.del].contains(value)
        ? Colors.red
        : [Button.clear].contains(value)
        ? Colors.green
        : [Button.percent, Button.div, Button.mul, Button.add, Button.min, Button.equal].contains(value)
        ? Colors.deepPurpleAccent.shade400
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: Transform.scale(
        scale: _scale,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: getButtonColor(widget.value),
          child: Center(
            child: Text(
              widget.value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: [Button.del, Button.clear, Button.equal, Button.mul, Button.div, Button.add, Button.min, Button.percent].contains(widget.value)
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}