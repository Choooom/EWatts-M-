import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: appBar(width)),
          SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverToBoxAdapter(child: header(width)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Performance",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.whiteWidgetBg,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: AspectRatio(
                  aspectRatio: 1 / 0.7,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Generating",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: BoxBorder.all(
                                    color: AppColors.whiteBodyBg,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.all(5),
                                  child: Row(
                                    children: [
                                      Text("Set power limit"),
                                      SizedBox(width: 5),
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center header(double width) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.whiteWidgetBg,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.greenActiveCircle,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Active',
                        style: TextStyle(
                          color: AppColors.greenText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Text(
                    'SOLAR S-784',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'In good condition',
                    style: TextStyle(color: AppColors.greyText, fontSize: 18),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/images/panels_screen/panel_3d.png",
                width: width * 0.29,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding appBar(double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteWidgetBg,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),

          Text(
            "Panel Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(width: width * 0.32),

          Container(
            decoration: BoxDecoration(
              color: AppColors.greenPowerButtonArea,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.greenPowerButtonBorder,
                width: 2,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Icon(Icons.power_settings_new),
            ),
          ),
        ],
      ),
    );
  }
}
