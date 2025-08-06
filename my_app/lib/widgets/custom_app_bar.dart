import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/widgets/tap_scale_effect.dart';

// ignore: must_be_immutable
class SecondaryAppBar extends StatelessWidget {
  String screeenName;
  SecondaryAppBar({super.key, required this.screeenName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        top: 40,
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            screeenName,
            style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TapScaleEffect(
            onTap: () => {},
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteWidgetBg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.more_horiz),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
