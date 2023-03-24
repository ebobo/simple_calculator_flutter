import 'package:flutter/material.dart';

class ResultsRow extends StatelessWidget {
  final double plusResult;
  final double minusResult;
  final double multiplyResult;
  final double divideResult;
  // final double indicatorSize = 40;

  const ResultsRow({
    Key? key,
    required this.plusResult,
    required this.minusResult,
    required this.multiplyResult,
    required this.divideResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildResultWidget(plusResult.toString()),
        _buildResultWidget(minusResult.toString()),
        _buildResultWidget(multiplyResult.toString()),
        _buildResultWidget(divideResult.toString()),
      ],
    );
  }

  Widget _buildResultWidget(String result) {
    return Expanded(
      child: Text(
        result,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
