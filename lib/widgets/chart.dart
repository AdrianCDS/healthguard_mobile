import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.data});

  final List<double> data;

  @override
  Widget build(BuildContext context) {
    double average = calculateAverage(data);
    double max = calculateMax(data);

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              max.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 2.0),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: ChartPainter(data: data, max: max),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: const Text(
              'Now',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text('Average:'),
              ),
              Text(
                average.toStringAsFixed(1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  double calculateAverage(List<double> data) {
    if (data.isEmpty) return 0.0;

    double sum = 0.0;

    for (var value in data) {
      sum += value;
    }
    return sum / data.length;
  }

  double calculateMax(List<double> data) {
    return data.reduce((curr, next) => curr > next ? curr : next);
  }
}

class ChartPainter extends CustomPainter {
  ChartPainter({required this.data, required this.max});

  final List<double> data;
  final double max;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double chartHeight = size.height - 5.0;
    final double chartWidth = size.width;
    final Paint charlinesPain = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(0, chartHeight);
    final double dataStep = chartWidth / (data.length - 1);
    for (int i = 0; i < data.length; i++) {
      double x = i * dataStep;
      double y = chartHeight - (data[i] / max) * chartHeight;
      path.lineTo(x, y);
    }
    canvas.drawPath(path, linePaint);

    canvas.drawLine(Offset(0, chartHeight), const Offset(0, 0), charlinesPain);
    canvas.drawLine(
        Offset(0, chartHeight), Offset(chartWidth, chartHeight), charlinesPain);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
