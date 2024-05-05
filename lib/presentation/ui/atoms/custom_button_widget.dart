import 'package:eye_ia_detection/core/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    required this.textButton,
    this.onTap,
  });

  String textButton;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          onTap?.call();
        },
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomColors.primary,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primary.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ]),
          width: double.infinity,
          // alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child: Text(
              textButton,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
