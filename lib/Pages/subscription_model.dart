import 'package:flutter/material.dart';

class SubscriptionPlan {
  final String name;
  final String description;
  final int monthlyPrice;
  final int annualPrice;
  final bool isPopular;
  final List<String> features;
  final Color gradientColor1;
  final Color gradientColor2;

  SubscriptionPlan({
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.annualPrice,
    this.isPopular = false,
    required this.features,
    required this.gradientColor1,
    required this.gradientColor2,
  });
}
