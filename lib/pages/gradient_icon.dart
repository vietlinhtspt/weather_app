import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final Icon icon;
  final Color startGradientColor;
  final Color endGradientColor;
  const GradientIcon(
      {Key key,
      @required this.icon,
      this.startGradientColor,
      this.endGradientColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 1.3,
          colors: <Color>[
            startGradientColor ?? Colors.blueAccent[200],
            endGradientColor ?? Colors.pinkAccent[200]
          ],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: icon,
    );
    // return Container(
    //   child: icon,
    // );
  }
}
