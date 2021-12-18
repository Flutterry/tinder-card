import 'dart:math';

import 'package:app/src/application.dart';

class CustomBanner extends StatelessWidget {
  final Status status;
  final Color color;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double opacity;
  const CustomBanner(
    this.status,
    this.color, {
    Key? key,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.opacity = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Center(
        child: Opacity(
          opacity: opacity,
          child: Transform.rotate(
            angle: status == Status.like
                ? -45 * pi / 180
                : status == Status.dislike
                    ? 45 * pi / 180
                    : 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color, width: 2),
              ),
              child: CustomText(
                text: enumToString(status),
                color: color,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
