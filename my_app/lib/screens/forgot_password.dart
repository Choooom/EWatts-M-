import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/screens/sign_up.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _LogInState();
}

class _LogInState extends State<ForgotPassword> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signUpWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);
        return Scaffold(
          body: Transform.translate(
            offset: const Offset(0, -10),
            child: Column(
              children: [
                header(width: width),

                h1(),
                SizedBox(height: 15),

                h2_email(),

                email_textfield(emailController: _emailController),

                SizedBox(height: 30),

                signin_button(),

                Expanded(child: SizedBox()),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 50,
                    horizontal: 25,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context, true),
                        child: Text("Go Back", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class bottom_text extends StatelessWidget {
  const bottom_text({super.key, required this.brightness});

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: AppColors.greyText(brightness), fontSize: 16),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    SignUp(),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
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
          },
          child: Text(
            "Register Now",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class oauth_accounts extends StatelessWidget {
  const oauth_accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: AppColors.greyBgColor, width: 2),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Image.asset(
              "assets/images/on_boarding/google.png",
              width: 25,
            ),
          ),
        ),
        SizedBox(width: 15),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: AppColors.greyBgColor, width: 2),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(7.5),
            child: Image.asset(
              "assets/images/on_boarding/discord.png",
              width: 30,
            ),
          ),
        ),
        SizedBox(width: 15),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: AppColors.greyBgColor, width: 2),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(7.5),
            child: Image.asset(
              "assets/images/on_boarding/facebook.png",
              width: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class or_bar extends StatelessWidget {
  const or_bar({super.key, required this.brightness});

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container(height: 2, color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "or",
              style: TextStyle(
                color: AppColors.greyText(brightness),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container(height: 2, color: Colors.grey)),
        ],
      ),
    );
  }
}

class signin_button extends StatelessWidget {
  const signin_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenActiveCircle, // button color
            foregroundColor: Colors.black, // text color
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class forgot_password_link extends StatelessWidget {
  const forgot_password_link({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Forgot password?",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class password_textfield extends StatelessWidget {
  final TextEditingController passwordController;

  const password_textfield({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outlined),
          hintText: "Input password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.greyBgColor),
          ),
        ),
      ),
    );
  }
}

class h2_password extends StatelessWidget {
  const h2_password({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Password",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class email_textfield extends StatelessWidget {
  final TextEditingController emailController;

  const email_textfield({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
          hintText: "Input your email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColors.greyBgColor,
              width: 10,
            ),
          ),
        ),
      ),
    );
  }
}

class h2_email extends StatelessWidget {
  const h2_email({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "E-mail",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class h1 extends StatelessWidget {
  const h1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Forgot Password",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class header extends StatelessWidget {
  const header({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/on_boarding/forgot-password.png",
      fit: BoxFit.cover,
      width: width,
    );
  }
}
