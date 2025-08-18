import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/util/snackbar.dart';
import 'package:my_app/util/validators.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  final String resetToken;
  const ResetPassword({
    super.key,
    required this.email,
    required this.resetToken,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isVisible = false;
  bool _isVisibleP = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

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

                    h2_password(text: "Password"),

                    password_textfield(
                      passwordController: _passwordController,
                      isVisible: _isVisible,
                      onVisibleToggle: () => setState(() {
                        _isVisible = !_isVisible;
                      }),
                    ),

                    SizedBox(height: 15),

                    h2_password(text: "Confirm Password"),

                    password_textfieldP(
                      passwordController: _confirmPasswordController,
                      isVisible: _isVisibleP,
                      onVisibleToggle: () => setState(() {
                        _isVisibleP = !_isVisibleP;
                      }),
                    ),

                    SizedBox(height: 30),

                    save_password_button(
                      ref: ref,
                      email: widget.email,
                      resetToken: widget.resetToken,
                      password: _passwordController,
                      confirmPassword: _confirmPasswordController,
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

class save_password_button extends StatelessWidget {
  final WidgetRef ref;
  final String email;
  final String resetToken;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  const save_password_button({
    super.key,
    required this.ref,
    required this.email,
    required this.resetToken,
    required this.password,
    required this.confirmPassword,
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
            final authState = ref.read(authProvider);

            final pword = password.text.trim();
            final confirmPword = confirmPassword.text.trim();

            final passwordErrorMessage = Validators.password(pword);
            final confirmPasswordErrorMessage = Validators.confirmPassword(
              confirmPword,
              pword,
            );

            if (passwordErrorMessage != null ||
                confirmPasswordErrorMessage != null) {
              CustomSnackBar.show(
                context,
                message: passwordErrorMessage ?? confirmPasswordErrorMessage!,
                backgroundColor: AppColors.redDottedLines,
                icon: Icons.warning_amber_rounded,
              );
            } else {
              if (authState.isLoading) return;

              final success = await authNotifier.setNewPassword(
                email: email,
                resetToken: resetToken,
                newPassword: pword,
                confirmPassword: confirmPword,
              );

              if (success) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenBottomRight, // button color
            foregroundColor: AppColors.black, // text color
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: ref.watch(authProvider).isLoading
              ? CircularProgressIndicator()
              : Text("Reset Password"),
        ),
      ),
    );
  }
}

class password_textfieldP extends StatelessWidget {
  final TextEditingController passwordController;
  final bool isVisible;
  final VoidCallback onVisibleToggle;

  const password_textfieldP({
    super.key,
    required this.passwordController,
    required this.isVisible,
    required this.onVisibleToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: passwordController,
        obscureText: !isVisible,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            onPressed: onVisibleToggle,
            icon: isVisible
                ? Icon(Icons.visibility_outlined)
                : Icon(Icons.visibility_off_outlined),
          ),
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

class password_textfield extends StatelessWidget {
  final TextEditingController passwordController;
  final bool isVisible;
  final VoidCallback onVisibleToggle;

  const password_textfield({
    super.key,
    required this.passwordController,
    required this.isVisible,
    required this.onVisibleToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: passwordController,
        obscureText: !isVisible,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            onPressed: onVisibleToggle,
            icon: isVisible
                ? Icon(Icons.visibility_outlined)
                : Icon(Icons.visibility_off_outlined),
          ),
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
  String text;
  h2_password({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
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
