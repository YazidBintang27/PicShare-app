import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/presentation/widgets/auth_textfield.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/presentation/widgets/button_stroke.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
              ),
              Image.asset(
                'assets/images/PicShare.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 32,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Register to ',
                    style: Theme.of(context).textTheme.headlineSmall),
                TextSpan(
                    text: 'PicShare',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary))
              ])),
              const SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              AuthTextfield(
                  hintText: 'Enter your username ...',
                  prefixIcon: HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    color: Color(0xFF262626),
                    size: 20,
                  ),
                  obscureText: false,
                  controller: _usernameController),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email Address',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              AuthTextfield(
                  hintText: 'Enter your email ...',
                  prefixIcon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMailAtSign02,
                    color: Color(0xFF262626),
                    size: 20,
                  ),
                  obscureText: false,
                  controller: _emailController),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              AuthTextfield(
                  hintText: 'Enter your password ...',
                  prefixIcon: HugeIcon(
                    icon: HugeIcons.strokeRoundedSquareLock02,
                    color: Color(0xFF262626),
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                      icon: HugeIcon(
                        icon: _isPasswordHidden
                            ? HugeIcons.strokeRoundedViewOff
                            : HugeIcons.strokeRoundedView,
                        color: Color(0xFF262626),
                        size: 20,
                      )),
                  obscureText: _isPasswordHidden,
                  controller: _passwordController),
              const SizedBox(
                height: 20,
              ),
              ButtonFill(text: 'REGISTER', action: () => context.pushReplacement('/login')),
              const Spacer(),
              ButtonStroke(text: 'LOGIN', action: () => context.pushReplacement('/login'))
            ],
          ),
        ),
      )),
    );
  }
}