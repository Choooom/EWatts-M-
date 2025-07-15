import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/user_detail.dart';
import 'package:my_app/widgets/energy_summary.dart';
import 'package:my_app/widgets/weather_status_widget.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

UserDetail userDetail = UserDetail(
  username: 'Romille',
  phoneNumber: '09296726163',
  email: 'romilleilaida420@gmail.com',
  password: 'Amen103',
);
String username = userDetail.username;

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Center(child: WeatherStatusWidget()),
          SizedBox(height: 5),
          Center(child: EnergySummary()),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text.rich(
        TextSpan(
          text: 'Hi, $username\n',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: 'Welcome Back',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 151, 151, 151),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => {print("Menu")},
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SvgPicture.asset(
            'assets/icons/menu_drawer.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => {},
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
