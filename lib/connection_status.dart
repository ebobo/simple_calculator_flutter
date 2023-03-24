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
        _buildIndicator(plusMicroserviceUp, "plus"),
        _buildIndicator(minusMicroserviceUp, "minus"),
        _buildIndicator(multiplyMicroserviceUp, "multiply"),
        _buildIndicator(divideMicroserviceUp, "divide"),
      ],
    );
  }

  Widget _buildIndicator(bool isUp, String type) {
    final IconData calIcon;
    switch (type) {
      case "plus":
        calIcon = Icons.add;
        break;
      case "minus":
        calIcon = Icons.remove;
        break;
      case "multiply":
        calIcon = Icons.close;
        break;
      case "divide":
        calIcon = Icons.percent;
        break;
      default:
        calIcon = Icons.add;
    }
    return Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: BoxDecoration(
        color: isUp ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(calIcon, color: Colors.white, size: 20)),
    );
  }
}
