import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/panels.dart';
import 'package:my_app/widgets/bottomNavBar.dart';
import 'package:my_app/widgets/panelListTile.dart';

class PanelsScreen extends StatelessWidget {
  const PanelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Panels> panels = [
      Panels(
        panelName: "SOLAR S-784",
        efficiencyLevel: 80,
        energyLevel: 1.3,
        status: true,
      ),
      Panels(panelName: "SOLAR S-779", efficiencyLevel: 0, energyLevel: 5.6),
      Panels(
        panelName: "SOLAR S-780",
        efficiencyLevel: 85,
        energyLevel: 1.3,
        status: true,
      ),
      Panels(panelName: "SOLAR S-790", efficiencyLevel: 8, energyLevel: 0),
      Panels(
        panelName: "SOLAR S-784",
        efficiencyLevel: 80,
        energyLevel: 1.3,
        status: true,
      ),
      Panels(panelName: "SOLAR S-779", efficiencyLevel: 0, energyLevel: 5.6),
      Panels(
        panelName: "SOLAR S-780",
        efficiencyLevel: 85,
        energyLevel: 1.3,
        status: true,
      ),
      Panels(panelName: "SOLAR S-790", efficiencyLevel: 8, energyLevel: 0),
      Panels(
        panelName: "SOLAR S-784",
        efficiencyLevel: 80,
        energyLevel: 1.3,
        status: true,
      ),
      Panels(panelName: "SOLAR S-779", efficiencyLevel: 0, energyLevel: 5.6),
      Panels(
        panelName: "SOLAR S-780",
        efficiencyLevel: 85,
        energyLevel: 1.3,
        status: true,
      ),
      Panels(panelName: "SOLAR S-790", efficiencyLevel: 8, energyLevel: 0),
    ];
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: appBar()),

          SliverToBoxAdapter(child: header(width)),

          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 15,
                      ),
                      child: Text(
                        "Panels",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20,
                      ),
                      child: Text(
                        "Total 32",
                        style: TextStyle(
                          color: AppColors.greyText,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                ListView.builder(
                  itemCount: panels.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 4,
                      ),
                      child: PanelTile(
                        panelName: panels[index].panelName,
                        panelEfficiency: panels[index].efficiencyLevel,
                        panelStatus: panels[index].status ? true : false,
                        panelEnergy: panels[index].energyLevel,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio header(double width) {
    return AspectRatio(
      aspectRatio: 1 / 0.6,
      child: Center(
        child: Container(
          width: width * 0.95,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/panels_screen/green_bg.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "All 32 Panel Online",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.055,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "It's a sunny day. All panels are online and in good condition",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Image.asset(
                      'assets/images/panels_screen/solar_panel.png',
                      width: width * 0.25,
                      height: width * 0.25,
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  width: width * 0.85,
                  child: AspectRatio(
                    aspectRatio: 1 / 0.25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "✨ AI optimization",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Increase efficiency and get more out of your panels",
                                    style: TextStyle(color: Colors.white),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding appBar() {
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
            'Panels',
            style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteWidgetBg,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    );
  }
}
