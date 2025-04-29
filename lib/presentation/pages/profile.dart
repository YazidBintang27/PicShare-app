import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/providers/main/index_nav_provider.dart';
import 'package:picshare_app/providers/profile/profile_provider.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        final state = provider.resultState;
        final response = provider.loginResponse;
        final name = response?.loginResult.name;
        final userId = response?.loginResult.userId;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(96, 41, 98, 253),
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/noimage.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$name',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              '$userId',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                state is AppLoadingState
                    ? const CircularProgressIndicator()
                    : ButtonFill(
                        text: 'LOGOUT',
                        action: () {
                          provider.logout();
                          context.go('/onboarding');
                          context
                              .read<IndexNavProvider>()
                              .setIndexBottomNavbar = 0;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logout success!')),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
