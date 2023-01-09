import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DiscountTag extends StatelessWidget {
  final int? size;
  final String discount;

  DiscountTag({this.size, required this.discount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(context.width() / 2 - 16, context.width() / 2 - 16),
      painter: DiscountPainter(discount: discount),
    );
  }
}

class DiscountPainter extends CustomPainter {
  final Color? color;
  final String discount;

  DiscountPainter({this.color, required this.discount});

  @override
  void paint(Canvas canvas, Size size) {
    double textLen = ((discount.length / 2) / 10);

    Paint paint = new Paint()
      ..color = color ?? Colors.red
      ..style = PaintingStyle.fill;
    Path path = Path();

    path.lineTo(size.width * textLen - 10, 0);
    path.lineTo(size.width * textLen - 15, size.height * textLen / 6.5);
    path.lineTo(size.width * textLen - 10, size.height * textLen / 3);
    path.lineTo(0, size.width * textLen / 3);

    canvas.drawPath(path, paint);

    final textSpan = TextSpan(text: discount.validate(), style: primaryTextStyle(size: size.width.toInt() ~/ 15, color: Colors.white));
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width) * 0.02,
        (size.height) * 0.025,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
