import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/models/auth/auth_requests.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/util/snackbar.dart';

class VerificationScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final VoidCallback onVerificationComplete;

  const VerificationScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.usernameController,
    required this.phoneNumberController,
    required this.onVerificationComplete,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, watch) {
        Brightness b = ref.watch(themeModeProvider);
        final authNotifier = ref.read(authProvider.notifier);
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 2,
              decoration: BoxDecoration(
                color: AppColors.whiteWidgetBg(b),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: AppColors.greenActiveCircle,
                      size: 100,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Enter OTP Code",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please type the OTP code sent to ${widget.emailController.text}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.greyText(b),
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 15),

                    GestureDetector(
                      onTap: () async {
                        final success = await ref
                            .read(authProvider.notifier)
                            .resendOtp(
                              ResendOtpRequest(
                                email: widget.emailController.text.trim(),
                              ),
                            );

                        if (success) {
                          CustomSnackBar.show(
                            context,
                            message: "A new OTP has been sent to your email.",
                            backgroundColor: AppColors.greenActiveCircle,
                            icon: Icons.check_circle_outline,
                          );
                        } else {
                          CustomSnackBar.show(
                            context,
                            message:
                                ref.read(authProvider).error ??
                                "Failed to resend OTP",
                            backgroundColor: AppColors.redDottedLines,
                            icon: Icons.error_outline,
                          );
                        }
                      },
                      child: Text(
                        "Resend code",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _otpController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: AppColors.greyText(b),
                          ),
                          hintText: "Input OTP Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.greyBgColor,
                              width: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final success = await authNotifier.verifyEmail(
                            EmailVerificationRequest(
                              email: widget.emailController.text,
                              otpCode: _otpController.text,
                            ),
                          );

                          if (success) {
                            CustomSnackBar.show(
                              context,
                              message: "Account verification successful.",
                              backgroundColor: AppColors.greenActiveCircle,
                              icon: Icons.check_circle_outline,
                            );
                            widget.onVerificationComplete();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // button color
                          foregroundColor: Colors.white, // text color
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
