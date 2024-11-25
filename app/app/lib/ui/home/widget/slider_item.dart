import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({super.key, required this.img_name});
  final String img_name;

  @override
  Widget build(BuildContext context) {
    return Image.asset(img_name);
  }
}
