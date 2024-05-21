import 'package:flutter/material.dart';
class MyElevatedButton extends StatefulWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final VoidCallback? onPressed;
  final Widget child;
  final Gradient gradiente;
  final Color backgroundColor;
  final Color shadowColor;
  

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradiente = const LinearGradient(colors: [Colors.black, Colors.white]),
    this.backgroundColor = Colors.transparent,
    this.shadowColor =  Colors.transparent,
  });

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  get backgroundColor => Colors.transparent;
  get shadowColor =>  Colors.transparent;
  //todo arreglar el estos parametros


  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: widget.gradiente,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: widget.child,
      ),
    );
  }
}