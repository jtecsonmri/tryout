import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:tryout/src/routes.dart';

class DefaultAppBarWidget extends StatefulWidget implements PreferredSizeWidget{
  const DefaultAppBarWidget({Key? key})
    : preferredSize = const Size.fromHeight(kToolbarHeight),super(key: key);

  @override
  State<DefaultAppBarWidget> createState() => _DefaultAppBarWidgetState();
  
  @override
  final Size preferredSize;
}

class _DefaultAppBarWidgetState extends State<DefaultAppBarWidget> {
  String? title = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (title == '') {
      title = AppLocalizations.of(context)?.appTitle;
    }
    return AppBar(
        centerTitle: true,
        title: Text(title ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            context.pushReplacement(Routes.enterCode);
          },
        ),
      );
  }
}