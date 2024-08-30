import 'package:flutter/material.dart';
import 'package:magic/src/presentation/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    super.key,
    this.color = Colors.white,
    this.textColor = const Color(0xFF4B4B4B),
    this.onPressed,
  });

  final String text;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            enableFeedback: true,
            overlayColor:
                MaterialStatePropertyAll(Color(MagicColors.secondary)),
            backgroundColor:
                MaterialStatePropertyAll(Color(MagicColors.yellow)),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
