import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/screens/reset_password.dart';
import 'package:my_app/screens/sign_up.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/util/snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends StatefulWidget {
  final String email;
  const OtpVerification({super.key, required this.email});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    onCompleted(String value) {}

    return Consumer(
      builder: (context, ref, child) {
        ref.listen(authProvider, (previous, next) {
          if (next.error != null) {
            CustomSnackBar.show(
              context,
              message: next.error!,
              backgroundColor: AppColors.redDottedLines,
              icon: Icons.warning_amber_rounded,
            );
          }
        });

        final authState = ref.watch(authProvider);
        final brightness = ref.watch(themeModeProvider);
        return Scaffold(
          body: Transform.translate(
            offset: const Offset(0, -10),
            child: Stack(
              children: [
                Column(
                  children: [
                    header(width: width),

                    h1(),
                    SizedBox(height: 15),

                    h2_email(email: widget.email, b: brightness),

                    SizedBox(height: 20),

                    otpField(
                      onCompleted: onCompleted,
                      otpValue: _otpController,
                    ),

                    SizedBox(height: 30),

                    signin_button(
                      ref: ref,
                      email: widget.email,
                      otpValue: _otpController,
                    ),

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
                            child: Text(
                              "Go Back",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (authState.isLoading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(child: CircularProgressIndicator()),
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
  WidgetRef ref;
  String email;
  TextEditingController otpValue;
  signin_button({
    super.key,
    required this.ref,
    required this.email,
    required this.otpValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            final authNotifier = ref.read(authProvider.notifier);

            final success = await authNotifier.verifyPasswordResetOtp(
              email,
              otpValue.text,
            );

            final resetToken = authNotifier.state.resetToken;
            if (resetToken == null) {
              // Show error UI, or block the action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please verify OTP first.")),
              );
              return;
            }

            if (success) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ResetPassword(email: email, resetToken: resetToken),
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
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenActiveCircle, // button color
            foregroundColor: Colors.black, // text color
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Send OTP",
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

class otpField extends StatelessWidget {
  final ValueChanged<String> onCompleted;
  final TextEditingController otpValue;

  const otpField({
    super.key,
    required this.onCompleted,
    required this.otpValue,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final int numberOfBoxes = 6;
    final double gap = 25;

    final totalGap = (numberOfBoxes - 1) * gap;
    final fieldWidth = (screenWidth - totalGap) / numberOfBoxes;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: PinCodeTextField(
        appContext: context,
        length: 6, // number of OTP digits
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: fieldWidth + 10,
          fieldWidth: fieldWidth,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          activeColor: Colors.blue,
          selectedColor: Colors.blue,
          inactiveColor: Colors.grey,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        onCompleted: onCompleted, // triggered when all boxes are filled
        controller: otpValue,
      ),
    );
  }
}

class h2_email extends StatelessWidget {
  final Brightness b;
  final String email;
  const h2_email({super.key, required this.email, required this.b});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Please enter the 6 digit code\nsent to $email",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.greyText(b),
            ),
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
