import 'package:flutter/material.dart';

class BMIWidget extends StatelessWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;

  const BMIWidget({
    required this.heightController,
    required this.weightController,
    super.key,
  });

  double calculateBMI() {
    final height = int.tryParse(heightController.text);
    final weight = int.tryParse(weightController.text);
    if (height != null && weight != null && height > 0 && weight > 0) {
      return weight / ((height / 100) * (height / 100));
    }
    return 0.0;
  }

  String getBMICategory(double bmi) {
    if (bmi < 16.0) {
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
