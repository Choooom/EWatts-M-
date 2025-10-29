import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/panels.dart';
import 'package:my_app/screens/panels_details.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/custom_app_bar.dart';
import 'package:my_app/widgets/panelListTile.dart';

class PanelsScreen extends StatefulWidget {
  const PanelsScreen({super.key});

  @override
  State<PanelsScreen> createState() => _PanelsScreenState();
}

class _PanelsScreenState extends State<PanelsScreen> {
  bool _showAllPanels = false;
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    final List<Panels> panels = [
      Panels(
        panelName: "SOLAR S-784",
        efficiencyLevel: 80,
        energyLevel: 1.3,
        status: true,
      ),
    ];
    final width = MediaQuery.sizeOf(context).width;
    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SecondaryAppBar(
                  screeenName: "Panels",
                  brightness: brightness,
                ),
              ),

              SliverToBoxAdapter(
                child: header(width, isSwitched, brightness, (newValue) {
                  setState(() {
                    isSwitched = newValue;
                  });
                }),
              ),

              SliverToBoxAdapter(child: panelList(panels, brightness)),
            ],
          ),
        );
      },
    );
  }

  Column panelList(List<Panels> panels, Brightness brightness) {
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
                style: TextStyle(
                  color: AppColors.greyText(brightness),
                  fontSize: 18,
                ),
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
                            style: TextStyle(
                              color: AppColors.greyText(brightness),
                            ),
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
                            style: TextStyle(
                              color: AppColors.greyText(brightness),
                            ),
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

  AspectRatio header(
    double width,
    bool isSwitched,
    Brightness brightness,
    ValueChanged<bool> onChanged,
  ) {
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
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blackLeft,
                          Color(0xFF2B2C33),
                          AppColors.blackRight,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    foregroundDecoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.02),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                            colors: [
                                              AppColors.goldRight,
                                              AppColors.goldLeft,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds),
                                      blendMode: BlendMode
                                          .srcIn, // Keeps image shape but applies gradient
                                      child: Image.asset(
                                        "assets/icons/star.png",
                                        width: width * 0.06,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                            colors: [
                                              AppColors.goldRight,
                                              AppColors.goldLeft,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ).createShader(
                                            Rect.fromLTWH(
                                              0,
                                              0,
                                              bounds.width,
                                              bounds.height,
                                            ),
                                          ),
                                      child: Text(
                                        "AI optimization",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Increase efficiency and get more out of your panels",
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      208,
                                      209,
                                      216,
                                    ),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                          Switch(value: isSwitched, onChanged: onChanged),
                        ],
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
