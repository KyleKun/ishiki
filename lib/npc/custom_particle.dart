import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TriangleComponent extends Component {
  @override
  void render(Canvas canvas) {
    canvas.drawPath(
        Path()
          ..moveTo(0, 4)
          ..lineTo(4 / 4, 0)
          ..lineTo(4, 4)
          ..lineTo(0, 4),
        Paint()..color = Colors.white);
  }

  @override
  void update(double dt) {}
}
