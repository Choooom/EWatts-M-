import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/constants/route_observer.dart';
import 'package:my_app/models/auth/auth_requests.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/screens/forgot_password.dart';
import 'package:my_app/screens/main_screen.dart';
import 'package:my_app/screens/sign_up.dart';
import 'package:my_app/services/auth/oauth_service.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:my_app/util/snackbar.dart';
import 'package:my_app/util/validators.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> with RouteAware {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();

  //oauth webview toh
  final bool _isLoading = false;

  final oauthManager = OAuthManager();

  @override
  void initState() {
    super.initState();

    oauthManager.initializeDeepLinking();
  }

  void _handleGitHubLogin() {
    oauthManager.startOAuthFlow(
      'github',
      context,
      onSuccess: () {
        // Navigate to your main app screen
        Navigator.of(context).pushReplacementNamed('/main');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful!')));
      },
      onError: (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed: $error')));
      },
    );
  }

  void _handleDiscordLogin() {
    oauthManager.startOAuthFlow(
      'discord',
      context,
      onSuccess: () {
        print(
          "It Pushed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
        );
        Navigator.of(context).push(MainNavigation() as Route<Object?>);
        CustomSnackBar.show(context, message: "Login Successful");
      },
      onError: (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed: $error')));
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void didPopNext() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

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

                    h1_signin(),
                    SizedBox(height: 15),
                    h2_email(),

                    email_textfield(emailController: _emailController),

                    SizedBox(height: 30),

                    h2_password(),

                    password_textfield(
                      passwordController: _passwordController,
                      isVisible: isVisible,
                      onVisibilityToggle: () => setState(() {
                        isVisible = !isVisible;
                      }),
                    ),

                    SizedBox(height: 15),

                    forgot_password_link(),

                    SizedBox(height: 30),

                    signin_button(
                      ref: ref,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                    ),
                    SizedBox(height: 15),

                    or_bar(brightness: brightness),

                    SizedBox(height: 15),

                    oauth_accounts(
                      isLoading: _isLoading,
                      discordCallBack: () => _handleDiscordLogin(),
                      githubCalllBack: () => _handleGitHubLogin(),
                    ),

                    SizedBox(height: 15),

                    bottom_text(brightness: brightness),
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
  bool isLoading;
  VoidCallback githubCalllBack;
  VoidCallback discordCallBack;
  oauth_accounts({
    super.key,
    required this.isLoading,
    required this.githubCalllBack,
    required this.discordCallBack,
  });

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
        GestureDetector(
          onTap: () {
            discordCallBack();
          },
          child: Container(
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
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () => githubCalllBack(),
          child: Container(
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
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final WidgetRef ref;
  final GlobalKey<FormState> formKey;

  const signin_button({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.ref,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            final emailErrorMessage = Validators.email(
              emailController.text.trim(),
            );
            final passwordErrorMessage = Validators.password(
              passwordController.text.trim(),
            );

            if (emailErrorMessage != null || passwordErrorMessage != null) {
              CustomSnackBar.show(
                context,
                message: emailErrorMessage ?? passwordErrorMessage!,
                backgroundColor: AppColors.redDottedLines,
                icon: Icons.warning_amber_rounded,
              );
            } else {
              final authNotifier = ref.read(authProvider.notifier);

              await authNotifier.login(
                LoginRequest(
                  usernameOrEmail: emailController.text.trim(),
                  password: passwordController.text.trim(),
                ),
              );
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
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ForgotPassword(),
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
              "Forgot password?",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class password_textfield extends StatelessWidget {
  final TextEditingController passwordController;
  bool isVisible;
  final VoidCallback onVisibilityToggle;

  password_textfield({
    super.key,
    required this.passwordController,
    required this.isVisible,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: passwordController,
        validator: Validators.password,
        obscureText: !isVisible,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            onPressed: onVisibilityToggle,
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

  email_textfield({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: Validators.email,
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

class h1_signin extends StatelessWidget {
  const h1_signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Sign In",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
      "assets/images/on_boarding/sign-in.png",
      fit: BoxFit.cover,
      width: width,
    );
  }
}
