import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';

class VeridoPrimaryButton extends StatefulWidget {
  const VeridoPrimaryButton(
      {Key? key, required this.onPressed, required this.title, this.isActive})
      : super(key: key);
  final void Function()? onPressed;
  final Widget title;
  final bool? isActive;

  @override
  _VeridoPrimaryButtonState createState() => _VeridoPrimaryButtonState();
}

class _VeridoPrimaryButtonState extends State<VeridoPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width < tabletBreakPoint ? 16 : 24,
            vertical: screenSize.width < tabletBreakPoint ? 16 : 24),
        child: widget.title,
      ),
    );
  }
}


class VeridoRedButton extends StatefulWidget {
  const VeridoRedButton(
      {Key? key, required this.onPressed, required this.title, this.isActive})
      : super(key: key);
  final void Function()? onPressed;
  final Widget title;
  final bool? isActive;

  @override
  _VeridoRedButtonState createState() => _VeridoRedButtonState();
}

class _VeridoRedButtonState extends State<VeridoRedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width < tabletBreakPoint ? 16 : 24,
            vertical: screenSize.width < tabletBreakPoint ? 16 : 24),
        child: widget.title,
      ),
    );
  }
}

