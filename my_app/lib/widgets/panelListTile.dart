import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteWidgetBg,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.whiteWidgetBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.whiteBodyBg, width: 4),
              ),
              child: Image.asset(
                'assets/images/panels_screen/panel_icon.png',
                width: width * 0.075,
              ),
            ),

            SizedBox(
              width: width * 0.5,
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
                          color: AppColors.greyText,
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
                  style: TextStyle(color: AppColors.greyText, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
