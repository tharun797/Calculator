import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.buttonName,
      required this.outerColour,
      required this.innerColour,
      required this.borderColour,
      required this.child,
      required this.onPressed});

  String buttonName;
  Color outerColour;
  Color innerColour;
  Color borderColour;
  Widget child;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Container(
          color: outerColour,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(innerColour),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: borderColour),
                    ),
                  ),
                ),
                child: child),
          ),
        ),
      ),
    );
  }
}
