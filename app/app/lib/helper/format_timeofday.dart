import 'package:flutter/material.dart';
String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hour.toString().padLeft(2, '0');
  final minute = timeOfDay.minute.toString().padLeft(2, '0');
  return '$hour:$minute'; // Định dạng HH:mm
}