import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  final double componentHeight = 60;

  double calculateFilledHeight(double percentage) {
    return (componentHeight * percentage) / 100;
  }

  ChartBar({
    @required this.label,
    @required this.value,
    @required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text("${value.toStringAsFixed(2)}"),
        ),
        SizedBox(height: 5),
        Container(
          height: componentHeight,
          width: 10,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5)),
              ),
              Container(
                height: calculateFilledHeight(percentage),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                    ),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
