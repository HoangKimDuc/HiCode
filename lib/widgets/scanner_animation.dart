import 'package:flutter/material.dart';

/// ## Hiệu ứng scan cho máy quét
class ScannerAnimation extends StatefulWidget {
  const ScannerAnimation({this.size, this.show});
  final double size;
  final bool show;
  @override
  _ScannerAnimationState createState() => _ScannerAnimationState();
}

class _ScannerAnimationState extends State<ScannerAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> verticalPosition;

  bool reverse = false;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );

    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    verticalPosition = Tween<double>(begin: 0.0, end: widget.size - 10)
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.slowMiddle,
    ))
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {
              animationController.reverse();
              reverse = true;
            } else if (state == AnimationStatus.dismissed) {
              animationController.forward();
              reverse = false;
            }
          });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) return SizedBox();
    return Positioned(
      top: (MediaQuery.of(context).size.height - widget.size) / 2 +
          verticalPosition.value -
          90,
      left: (MediaQuery.of(context).size.width - widget.size) / 2,
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Container(
          margin:
              EdgeInsets.only(top: reverse ? 0 : 24, bottom: reverse ? 24 : 0),
          width: widget.size,
          height: 0.2,
          decoration: BoxDecoration(color: Colors.red, boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              spreadRadius: 1.5,
              color: Colors.red,
            ),
          ]),
        ),
      ),
    );
  }
}
