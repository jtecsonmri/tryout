import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../models/user.dart';
import '../routes.dart';
class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});
  static const padding = EdgeInsets.symmetric(horizontal: 20);
@override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          color: const Color.fromRGBO(50, 55, 205, 1),
          child: ListView(
            children: <Widget>[
              buildHeader(
                context,
                urlImage: urlImage,
                name: name,
                email: email,
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      route: Routes.home,
                      text: AppLocalizations.of(context)!.menuHome,
                      icon: Icons.home,
                    ),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      route: Routes.profile,
                      text: AppLocalizations.of(context)!.menuProfile,
                      icon: Icons.manage_accounts,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      route: Routes.settings,
                      text: AppLocalizations.of(context)!.menuSettings,
                      icon: Icons.update,
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      route: Routes.aboutus,
                      text: AppLocalizations.of(context)!.menuAboutUs,
                      icon: Icons.info,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      route: Routes.contactus,
                      text: AppLocalizations.of(context)!.menuContactUs,
                      icon: Icons.contact_support,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      route: Routes.logout,
                      text: AppLocalizations.of(context)!.menuLogout,
                      icon: Icons.logout,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      route: Routes.notify,
                      text: AppLocalizations.of(context)!.menuNotifications,
                      icon: Icons.notifications,
                    ),                    
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem(
    BuildContext context, {
    required String route,
    required String text,
    required IconData icon,
  }) {
    //final provider = Provider.of<NavStore>(context);
    //final currentItem = provider.navigationItem;
    final isSelected = false;
    //item == currentItem;

    final color = isSelected ? Colors.orangeAccent : Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color, fontSize: 16)),
        onTap: () => selectItem(context, route),
      ),
    );
  }

  void selectItem(BuildContext context, String item) {
    Future.delayed(const Duration(milliseconds: 0), () {
      context.pushReplacement(item);
    });
  }

  Widget buildHeader(
    BuildContext context, {
    required String urlImage,
    required String name,
    required String email,
  }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          //onTap: () => selectItem(context, Routes.profile),
          child: Container(
            padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(urlImage)),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                  child: Icon(Icons.add_comment_outlined, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
}