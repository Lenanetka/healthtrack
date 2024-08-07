import 'package:flutter/material.dart';

class BMIWidget extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;

  const BMIWidget({
    required this.heightController,
    required this.weightController,
    super.key,
  });

  @override
  BMIWidgetState createState() => BMIWidgetState();
}

class BMIWidgetState extends State<BMIWidget> {
  double _height = 0.0;
  double _weight = 0.0;

  @override
  void initState() {
    super.initState();
    _height = double.tryParse(widget.heightController.text) ?? 0.0;
    _weight = double.tryParse(widget.weightController.text) ?? 0.0;
    widget.heightController.addListener(_updateBMI);
    widget.weightController.addListener(_updateBMI);
  }

  @override
  void dispose() {
    widget.heightController.removeListener(_updateBMI);
    widget.weightController.removeListener(_updateBMI);
    super.dispose();
  }

  void _updateBMI() {
    setState(() {
      _height = double.tryParse(widget.heightController.text) ?? 0.0;
      _weight = double.tryParse(widget.weightController.text) ?? 0.0;
    });
  }

  double calculateBMI() {
    bool isHeightValid = _height > 40 && _height < 300;
    bool isWeightValid = _weight > 10 && _weight < 1000;
    if (isHeightValid && isWeightValid) return _weight / ((_height / 100) * (_height / 100));
    return 0.0;
  }

  String getBMICategory(double bmi) {
    if (bmi == 0.0) {
      return 'N/A';
    } else if (bmi < 16.0) {
      return 'Underweight III';
    } else if (bmi < 17.0) {
      return 'Underweight II';
    } else if (bmi < 18.5) {
      return 'Underweight I';
    } else if (bmi < 25.0) {
      return 'Normal weight';
    } else if (bmi < 30.0) {
      return 'Overweight';
    } else if (bmi < 35.0) {
      return 'Obesity I';
    } else if (bmi < 40.0) {
      return 'Obesity II';
    } else {
      return 'Obesity III';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBMI();
    final bmiCategory = getBMICategory(bmi);
    _updateBMI();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BMI: ${bmi.toStringAsFixed(1)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          bmiCategory,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
