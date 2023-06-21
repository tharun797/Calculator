import 'package:calculator/components/custom_button.dart';
import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'components/display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textEditingController = TextEditingController();
  String calculate = '0';
  bool isReverse = true;
  bool evaluated = false;
  bool isFractionPressed = false;
  final ScrollController _scrollController = ScrollController();
  List<String> buttonName = [
    'C',
    '½',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    '',
    '='
  ];

  void calculator() {
    evaluated = true;
    var question = calculate;

    question = question.replaceAll('x', '*');
    question = question.replaceAll('÷', '/');
    question = question.replaceAll('½', '1/2');
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(question);
      ContextModel cm = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, cm);
      setState(() {
        calculate = result.toString();
        calculate = calculate.replaceAll('.0', '');
      });
    } catch (e) {
      isReverse = false;

      setState(() {
        calculate = kError;
      });
      _scrollController.animateTo(360,
          duration: const Duration(seconds: 2), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Display(
                scrollController: _scrollController,
                isReverse: isReverse,
                calculate: calculate),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    if (index == 3 ||
                        index == 7 ||
                        index == 11 ||
                        index == 15) {
                      return CustomButton(
                        buttonName: buttonName[index],
                        outerColour: kGreyColour,
                        innerColour: kGreyColour,
                        borderColour: kGreyColour,
                        onPressed: () {
                          setState(() {
                            isFractionPressed = false;
                            evaluated = false;
                            if (index == 15 && calculate == '0') {
                              calculate = buttonName[index];
                            } else {
                              if (calculate != '0') {
                                if (calculate != kError) {
                                  calculate += buttonName[index];
                                }
                              }
                            }

                            if (calculate == '0' && index == 15) {
                              if (calculate != kError) {
                                calculate += buttonName[index];
                              }
                            }
                          });
                        },
                        child: Text(buttonName[index], style: kTextStyle),
                      );
                    } else if (index == 1) {
                      return CustomButton(
                        buttonName: buttonName[index],
                        outerColour: kWhiteColour,
                        innerColour: kWhiteColour,
                        borderColour: kWhiteColour,
                        onPressed: () {
                          setState(() {
                            if (calculate != kError) {
                              if (isFractionPressed == false) {
                                if (calculate == '0') {
                                  calculate = buttonName[index];
                                } else {
                                  calculate += buttonName[index];
                                }
                              }
                            }
                          });
                        },
                        child: Text(
                          buttonName[index],
                          style: kTextStyle.copyWith(color: Colors.black54),
                        ),
                      );
                    } else if (index == 2) {
                      return CustomButton(
                        buttonName: buttonName[index],
                        outerColour: kWhiteColour,
                        innerColour: kWhiteColour,
                        borderColour: kWhiteColour,
                        onPressed: () {
                          setState(() {
                            isFractionPressed = false;
                            if (calculate != kError) {
                              calculate += buttonName[index];
                            }
                          });
                        },
                        child: Text(
                          buttonName[index],
                          style: kTextStyle.copyWith(color: Colors.black54),
                        ),
                      );
                    } else if (index == 0) {
                      return CustomButton(
                        buttonName: buttonName[index],
                        outerColour: kWhiteColour,
                        innerColour: kCButtonColour,
                        borderColour: Colors.white,
                        onPressed: () {
                          setState(() {
                            isFractionPressed = false;
                            evaluated = false;
                            calculate = '0';
                          });
                        },
                        child: Text(buttonName[index], style: kTextStyle),
                      );
                    } else if (index == 19) {
                      return CustomButton(
                        buttonName: buttonName[index],
                        outerColour: kOrangeColour,
                        innerColour: kOrangeColour,
                        borderColour: kOrangeColour,
                        onPressed: () => calculator(),
                        child: Text(buttonName[index], style: kTextStyle),
                      );
                    } else if (index == 18) {
                      return CustomButton(
                          buttonName: buttonName[index],
                          outerColour: kWhiteColour,
                          innerColour: kWhiteColour,
                          borderColour: kWhiteColour,
                          onPressed: () {
                            setState(() {
                              if (calculate != kError) {
                                calculate = calculate.substring(
                                    0, calculate.length - 1);
                                if (calculate == '') {
                                  calculate = '0';
                                }
                              }
                            });
                          },
                          child: const Icon(
                            Icons.backspace_outlined,
                            color: Colors.black54,
                          ));
                    } else {
                      return CustomButton(
                        buttonName: buttonName[index],
                        outerColour: kWhiteColour,
                        innerColour: kWhiteColour,
                        borderColour: kWhiteColour,
                        onPressed: () {
                          setState(() {
                            isFractionPressed = true;
                            if (calculate == '0') {
                              evaluated = false;
                              calculate = buttonName[index];
                            } else {
                              if (calculate != kError) {
                                if (evaluated == false) {
                                  calculate += buttonName[index];
                                } else {
                                  evaluated = false;
                                  calculate = buttonName[index];
                                }
                              }
                            }
                          });
                        },
                        child: Text(
                          buttonName[index],
                          style: kTextStyle.copyWith(color: Colors.black54),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
