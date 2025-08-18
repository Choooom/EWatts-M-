import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/energyDiagram.dart';

class EnergySummary extends StatelessWidget {
  const EnergySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.sizeOf(context).width * 0.9;

    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 1,
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Material(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Container(
              width: containerWidth,
              decoration: BoxDecoration(
                color: AppColors.whiteWidgetBg(brightness),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: EnergyDiagram(width: containerWidth),
              ),
            ),
          ),
        );
      },
    );
  }
}
