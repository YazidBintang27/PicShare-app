import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picshare_app/providers/register/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/presentation/widgets/auth_textfield.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/presentation/widgets/button_stroke.dart';
import 'package:picshare_app/utils/app_state.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _isPasswordHidden = context.watch<RegisterProvider>().isPasswordHidden;
    return Scaffold(
      body: SafeArea(
        child: Consumer<RegisterProvider>(
          builder: (context, provider, _) {
            final state = provider.resultState;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state is AppLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration success!')),
                );
                context.go('/login');
              } else if (state is AppErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration fail!')),
                );
              }
            });

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 28),
                            Image.asset('assets/images/PicShare.png', width: 100, height: 100),
                            const SizedBox(height: 32),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'Register to ',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              TextSpan(
                                text: 'PicShare',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.primary),
                              ),
                            ])),
                            const SizedBox(height: 60),
                            _buildLabel(context, 'Username'),
                            AuthTextfield(
                              hintText: 'Enter your username ...',
                              prefixIcon: HugeIcon(
                                icon: HugeIcons.strokeRoundedUser,
                                color: const Color(0xFF262626),
                                size: 20,
                              ),
                              obscureText: false,
                              controller: _usernameController,
                            ),
                            _buildLabel(context, 'Email Address'),
                            AuthTextfield(
                              hintText: 'Enter your email ...',
                              prefixIcon: HugeIcon(
                                icon: HugeIcons.strokeRoundedMailAtSign02,
                                color: const Color(0xFF262626),
                                size: 20,
                              ),
                              obscureText: false,
                              controller: _emailController,
                            ),
                            _buildLabel(context, 'Password'),
                            AuthTextfield(
                              hintText: 'Enter your password ...',
                              prefixIcon: HugeIcon(
                                icon: HugeIcons.strokeRoundedSquareLock02,
                                color: const Color(0xFF262626),
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => context.read<RegisterProvider>().passwordVisibility(),
                                icon: HugeIcon(
                                  icon: _isPasswordHidden
                                      ? HugeIcons.strokeRoundedViewOff
                                      : HugeIcons.strokeRoundedView,
                                  color: const Color(0xFF262626),
                                  size: 20,
                                ),
                              ),
                              obscureText: _isPasswordHidden,
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 20),
                            state is AppLoadingState
                                ? const CircularProgressIndicator()
                                : ButtonFill(
                                    text: 'REGISTER',
                                    action: () {
                                      provider.register(
                                        _usernameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    },
                                  ),
                            const Spacer(),
                            ButtonStroke(
                              text: 'LOGIN',
                              action: () => context.go('/login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(label, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
