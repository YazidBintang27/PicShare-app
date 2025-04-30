import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/presentation/widgets/auth_textfield.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/presentation/widgets/button_stroke.dart';
import 'package:picshare_app/providers/login/login_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (context, provider, _) {
            final state = provider.resultState;
            final isPasswordHidden = provider.isPasswordHidden;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state is AppLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login success!')),
                );
                context.go('/main');
                provider.resetState();
              } else if (state is AppErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login fail!')),
                );
                provider.resetState();
              }
            });

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 28),
                            Image.asset(
                              'assets/images/PicShare.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 32),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Login to ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  TextSpan(
                                    text: 'PicShare',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
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
                                onPressed: () => context
                                    .read<LoginProvider>()
                                    .passwordVisibility(),
                                icon: HugeIcon(
                                  icon: isPasswordHidden
                                      ? HugeIcons.strokeRoundedViewOff
                                      : HugeIcons.strokeRoundedView,
                                  color: const Color(0xFF262626),
                                  size: 20,
                                ),
                              ),
                              obscureText: isPasswordHidden,
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 20),
                            state is AppLoadingState
                                ? const CircularProgressIndicator()
                                : ButtonFill(
                                    text: 'LOGIN',
                                    action: () {
                                      provider.login(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    },
                                  ),
                            const Spacer(),
                            ButtonStroke(
                                text: 'REGISTER',
                                action: () {
                                  context.pop();
                                  context.push('/register');
                                }),
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
