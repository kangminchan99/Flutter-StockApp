import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:stock_app/core/helper/helper.dart';
import 'package:stock_app/domain/model/intraday_info_model.dart';

class StockChart extends StatelessWidget {
  final List<IntradayInfoModel> infos;
  final Color color;

  const StockChart({super.key, this.infos = const [], required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: CustomPaint(painter: ChartPainter(infos, color: color)),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<IntradayInfoModel> infos;
  final Color color;
  late Paint strokePaint;
  ChartPainter(this.infos, {required this.color}) {
    strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
  }

  late int upperValue = infos.map((e) => e.close).fold<double>(0.0, max).ceil();

  late int lowerValue = infos.map((e) => e.close).reduce(min).toInt();

  final spacing = 50.0;

  @override
  void paint(Canvas canvas, Size size) {
    final priceStep = (upperValue - lowerValue) / 5.0;
    for (var i = 0; i < 5; i++) {
      final textSpan = TextSpan(
        text: '${(lowerValue + priceStep * i).round()}',
        style: TextStyle(fontSize: 12, color: color),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(10, size.height - spacing - i * (size.height / 5.0)),
      );
    }

    final spacePerMin = (size.width - spacing) / infos.length;

    for (var i = 0; i < infos.length; i += 20) {
      final reverseIdx = infos.length - 1 - i; // 데이터 인덱스만 뒤집기
      final label = Helper.formatDate(infos[reverseIdx].date);

      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(fontSize: 12, color: color),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end,
      )..layout();

      tp.paint(canvas, Offset(i * spacePerMin + spacing, size.height - 20));
    }

    var lastX = 0.0;
    final strokePath = Path();
    for (var i = 0; i < infos.length; i++) {
      final reverseIdx = infos.length - 1 - i;
      final info = infos[reverseIdx];
      var nextIdx = reverseIdx - 1;
      if (nextIdx < 0) nextIdx = 0;
      final nextInfo = infos[nextIdx];
      final leftRatio = (info.close - lowerValue) / (upperValue - lowerValue);
      final rightRatio =
          (nextInfo.close - lowerValue) / (upperValue - lowerValue);

      final x1 = spacing + i * spacePerMin;
      final y1 = size.height - 30 - (leftRatio * size.height).toDouble();

      final x2 = spacing + (i + 1) * spacePerMin;
      final y2 = size.height - 30 - (rightRatio * size.height).toDouble();

      if (i == 0) {
        strokePath.moveTo(x1, y1);
      }
      lastX = (x1 + x2) / 2.0;
      strokePath.quadraticBezierTo(x1, y1, lastX, (y1 + y2) / 2.0);
    }

    // 영역 그려서 채우기
    final fillPath = Path.from(strokePath)
      ..lineTo(lastX, size.height - spacing)
      ..lineTo(spacing, size.height - spacing)
      ..close();

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.height - spacing),
        [color.withValues(alpha: 0.5), Colors.transparent],
      );

    canvas.drawPath(fillPath, fillPaint);

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) {
    // 데이터가 바뀔 때 다시 그리기
    return oldDelegate.infos != infos;
  }
}
