import 'package:flutter/material.dart';

class CustomElevateButton extends StatelessWidget {
  const CustomElevateButton({
    Key? key,
    required this.bgColor,
     this.icon,
     this.iconColor,
    required this.isIcons,
    required this.onpress,
   this.text,
    required this.textColor,
  }) : super(key: key);

  final Function() onpress; 
  final String? text;
  final bool isIcons;
  final Icon? icon;
  final Color textColor;
  final Color bgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor 
      ),
      onPressed: onpress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isIcons && icon != null) ...[
            Icon(
              icon?.icon,
              color: iconColor,
            ),
            const SizedBox(width: 8), 
          ],
          Text(
            text??'',
            style: TextStyle(color: textColor), 
          ),
        ],
      ),
    );
  }
}
