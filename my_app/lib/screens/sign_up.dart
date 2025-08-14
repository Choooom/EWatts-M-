import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Consumer(
      builder: (context, ref, child) {
        final brightness = ref.watch(themeModeProvider);
        return Scaffold(
          body: Column(
            children: [
              header(width: width),

              h1_signup(),

              h2(text: "Username"),

              SizedBox(height: 5),

              username_textfield(
                usernameController: _usernameController,
                brightness: brightness,
              ),

              SizedBox(height: 10),

              h2(text: "Phone Number"),

              SizedBox(height: 5),

              phone_number_textfield(
                phoneNumberController: _phoneNumberController,
                brightness: brightness,
              ),

              SizedBox(height: 10),

              h2(text: "E-mail"),

              SizedBox(height: 5),

              email_textfield(emailController: _emailController),

              SizedBox(height: 10),

              h2(text: "Password"),

              SizedBox(height: 5),

              password_textfield(
                passwordController: _passwordController,
                isVisible: isVisible,
                onVisibleToggle: () => setState(() {
                  isVisible = !isVisible;
                }),
              ),

              SizedBox(height: 20),

              signup_button(),

              SizedBox(height: 15),

              or_bar(brightness: brightness),

              SizedBox(height: 15),

              oauth_accounts(),

              SizedBox(height: 15),

              bottom_text(brightness: brightness),
            ],
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
          "Have an account?",
          style: TextStyle(color: AppColors.greyText(brightness), fontSize: 16),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: Text(
            "Login Now",
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

class signup_button extends StatelessWidget {
  const signup_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // button color
            foregroundColor: Colors.white, // text color
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

class phone_number_textfield extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final Brightness brightness;

  const phone_number_textfield({
    super.key,
    required this.phoneNumberController,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone, color: AppColors.greyText(brightness)),
          hintText: "Input phone number",
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

class username_textfield extends StatelessWidget {
  final TextEditingController usernameController;
  final Brightness brightness;

  const username_textfield({
    super.key,
    required this.usernameController,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: usernameController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: AppColors.greyText(brightness)),
          hintText: "Input username",
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

class h2 extends StatelessWidget {
  final String text;
  const h2({super.key, required this.text});

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

class h1_signup extends StatelessWidget {
  const h1_signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Sign Up",
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
      "assets/images/on_boarding/sign-up.png",
      fit: BoxFit.cover,
      width: width,
    );
  }
}
