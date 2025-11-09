import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class PanelTile extends StatelessWidget {
  final String panelName;
  final double panelEfficiency;
  final bool panelStatus;
  final double panelEnergy;

  const PanelTile({
    super.key,
    required this.panelName,
    required this.panelEfficiency,
    required this.panelStatus,
    required this.panelEnergy,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Ink(
          decoration: BoxDecoration(
            color: AppColors.whiteWidgetBg(brightness),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ink(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteWidgetBg(brightness),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.whiteBodyBg(brightness),
                      width: 3,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/panels_screen/panel_icon.png',
                    width: width * 0.075,
                  ),
                ),

                SizedBox(
                  width: width * 0.4,
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(left: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            panelName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Efficiency $panelEfficiency%",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText(brightness),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      panelStatus ? "Active" : "Offline",
                      style: TextStyle(
                        color: panelStatus ? Colors.green : Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '⚡ $panelEnergy kwh',
                      style: TextStyle(
                        color: AppColors.greyText(brightness),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
