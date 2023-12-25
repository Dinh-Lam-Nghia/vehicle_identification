import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/app/utils/app_provider.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primary,
      elevation: 0,
      title: Text(
        title.toUpperCase(),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () {
              context.read<AppProvider>().changeLocale();
            },
            icon: const Icon(Icons.language))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
