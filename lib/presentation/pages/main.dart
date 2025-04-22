import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:picshare_app/presentation/pages/add_picture.dart';
import 'package:picshare_app/presentation/pages/home.dart';
import 'package:picshare_app/presentation/pages/profile.dart';
import 'package:picshare_app/providers/main/index_nav_provider.dart';
import 'package:provider/provider.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<IndexNavProvider>().indexBottomNavbar;
    final primary = Theme.of(context).colorScheme.primary;
    final tertiary = Theme.of(context).colorScheme.tertiary;
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          context.read<IndexNavProvider>().setIndexBottomNavbar = 0;
          return false; // prevent default back behavior
        }
        return true; // allow exit if already in Home (index 0)
      },
      child: Scaffold(
        body: Consumer<IndexNavProvider>(builder: (context, value, child) {
          return switch (value.indexBottomNavbar) {
            0 => const Home(),
            1 => const AddPicture(),
            _ => const Profile()
          };
        }),
        bottomNavigationBar: selectedIndex == 1
            ? const SizedBox.shrink()
            : BottomNavigationBar(
                currentIndex:
                    context.watch<IndexNavProvider>().indexBottomNavbar,
                onTap: (index) => context
                    .read<IndexNavProvider>()
                    .setIndexBottomNavbar = index,
                selectedLabelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                items: [
                    BottomNavigationBarItem(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedHome11,
                          color: selectedIndex == 0 ? primary : tertiary,
                          size: 24.0,
                        ),
                        label: "",
                        tooltip: 'Home'),
                    BottomNavigationBarItem(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedAddSquare,
                          color: selectedIndex == 1 ? primary : tertiary,
                          size: 24.0,
                        ),
                        label: "",
                        tooltip: 'Add'),
                    BottomNavigationBarItem(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedUser03,
                          color: selectedIndex == 2 ? primary : tertiary,
                          size: 24.0,
                        ),
                        label: "",
                        tooltip: 'Profile'),
                  ]),
      ),
    );
  }
}
