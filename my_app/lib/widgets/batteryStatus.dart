import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/chargeMeter.dart';

class BatteryStatus extends StatefulWidget {
  const BatteryStatus({super.key});

  @override
  State<BatteryStatus> createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus> {
  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.sizeOf(context).width * 0.9;
    final containerHeight = MediaQuery.sizeOf(context).height;

    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Container(
          width: containerWidth,
          decoration: BoxDecoration(
            color: AppColors.whiteWidgetBg(brightness),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 1,
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 1.99,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final totalHeight = constraints.maxHeight;

                // Estimate height taken by paddings and text rows
                const headerHeight = 15 + 10 + 40 + 25; // adjust as needed

                final remainingHeight = totalHeight - headerHeight;

                return Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Charging",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text("82%", style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "1hr 10 min remained",
                              style: TextStyle(
                                color: AppColors.greyText(brightness),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "4500 kw cap",
                              style: TextStyle(
                                color: AppColors.greyText(brightness),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return BatteryChargeMeter(
                              batteryLevel: 3671,
                              batteryCapacity: 4500,
                              maxWidth: constraints.maxWidth,
                              maxHeight: constraints.maxHeight,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
