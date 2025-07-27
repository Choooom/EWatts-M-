import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/devices.dart';

class DeviceCard extends StatelessWidget {
  final Devices device;
  const DeviceCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteWidgetBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 7,
                  vertical: 10,
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteWidgetBg,
                    shape: BoxShape.circle,
                    border: BoxBorder.all(color: Colors.black, width: 2),
                  ),
                  child: Icon(Icons.tv),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7.0,
                  vertical: 5,
                ),
                child: Icon(Icons.arrow_outward_outlined),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 7, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  device.deviceCount.toStringAsFixed(0),
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  device.deviceName,
                  style: TextStyle(color: AppColors.greyText, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
