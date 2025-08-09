import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/widgets/tap_scale_effect.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;

  const CustomAppBar({super.key, required this.username});

  @override
  Size get preferredSize => const Size.fromHeight(100); // true usable height

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);

        return Container(
          height: preferredSize.height,
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          color: AppColors.whiteBodyBg(brightness),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading Button
              TapScaleEffect(
                onTap: () => print("Menu"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteWidgetBg(brightness),
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/menu_drawer.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ),

              // Title Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hi, $username 👏',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 151, 151, 151),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Trailing Button
              TapScaleEffect(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteWidgetBg(brightness),
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/notification.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
