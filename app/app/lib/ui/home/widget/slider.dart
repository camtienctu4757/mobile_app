import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'slider_item.dart';

class VerticalSlider extends StatelessWidget {
  const VerticalSlider({super.key, required this.imgs});
  final List<String> imgs;
  @override
  Widget build(BuildContext context) {
    List<Widget>? list = imgs.map((e) => SliderItem(img_name: e)).toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        aspectRatio: 3.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: list,
    );
  }
}
