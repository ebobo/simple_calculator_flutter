import 'package:flutter/material.dart';

class ConnectionStatusRow extends StatelessWidget {
  final bool plusMicroserviceUp;
  final bool minusMicroserviceUp;
  final bool multiplyMicroserviceUp;
  final bool divideMicroserviceUp;
  final double indicatorSize = 40;

  const ConnectionStatusRow({
    Key? key,
    required this.plusMicroserviceUp,
    required this.minusMicroserviceUp,
    required this.multiplyMicroserviceUp,
    required this.divideMicroserviceUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: plusMicroserviceUp ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Center(
              child: Icon(Icons.add, color: Colors.white, size: 20)),
        ),
        Container(
            width: indicatorSize,
            height: indicatorSize,
            decoration: BoxDecoration(
              color: minusMicroserviceUp ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
                child: Icon(Icons.remove, color: Colors.white, size: 20))),
        Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: minusMicroserviceUp ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Center(
              child: Icon(Icons.close, color: Colors.white, size: 20)),
        ),
        Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: minusMicroserviceUp ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Center(
              child: Icon(Icons.percent, color: Colors.white, size: 20)),
        ),
      ],
    );
  }
}
