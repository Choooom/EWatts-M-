import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/panels.dart';
import 'package:my_app/screens/panels_details.dart';
import 'package:my_app/widgets/custom_app_bar.dart';
import 'package:my_app/widgets/panelListTile.dart';

class PanelsScreen extends StatefulWidget {
  const PanelsScreen({super.key});

  @override
  State<PanelsScreen> createState() => _PanelsScreenState();
}

class _PanelsScreenState extends State<PanelsScreen> {
  bool _showAllPanels = false;

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
          SliverToBoxAdapter(child: SecondaryAppBar(screeenName: "Panels")),

          SliverToBoxAdapter(child: header(width)),

          SliverToBoxAdapter(child: panelList(panels)),
        ],
      ),
    );
  }

  Column panelList(List<Panels> panels) {
    return Column(
      children: [
        Row(
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15),
              child: Text(
                "Panels",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15),
              child: Text(
                "Total 32",
                style: TextStyle(color: AppColors.greyText, fontSize: 18),
              ),
            ),
          ],
        ),

        Column(
          children: [
            ListView.builder(
              itemCount: _showAllPanels
                  ? panels.length
                  : (panels.length > 4 ? 4 : panels.length),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final isLastVisible =
                    !_showAllPanels && index == 3 && panels.length > 4;
                final isLastItem =
                    _showAllPanels &&
                    index == panels.length - 1 &&
                    panels.length > 4;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 4,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    PanelsDetails(
                                      panelName: panels[index].panelName,
                                      panelStatus: panels[index].status
                                          ? "Active"
                                          : "Offline",
                                    ),
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(1, 0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(CurveTween(curve: curve));

                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    ),
                                  );
                                },
                          ),
                        ),
                        child: PanelTile(
                          panelName: panels[index].panelName,
                          panelEfficiency: panels[index].efficiencyLevel,
                          panelStatus: panels[index].status,
                          panelEnergy: panels[index].energyLevel,
                        ),
                      ),
                      if (isLastVisible)
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  Set<WidgetState> states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return Colors.grey.withValues(alpha: 0.2);
                                  }
                                  return null;
                                }),
                          ),
                          onPressed: () {
                            setState(() {
                              _showAllPanels = true;
                            });
                          },
                          child: Text(
                            'Show All',
                            style: TextStyle(color: AppColors.greyText),
                          ),
                        ),
                      if (isLastItem)
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  Set<WidgetState> states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return Colors.grey.withValues(alpha: 0.2);
                                  }
                                  return null;
                                }),
                          ),
                          onPressed: () {
                            setState(() {
                              _showAllPanels = false;
                            });
                          },
                          child: Text(
                            'Show Less',
                            style: TextStyle(color: AppColors.greyText),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
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
}
