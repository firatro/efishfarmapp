import 'package:efishfarmapp/core/extensions/l10n_exntesions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restart_app/restart_app.dart';

class DarkPage extends StatelessWidget {
  DarkPage({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.dark_mode),
      ),
      body: Column(
        children: [
          ListTile(
            trailing: Icon(Icons.sunny),
            title: Text(context.translate.light_mode),
            onTap: () {
              box.write("dark_mode", "false");
              Restart.restartApp();
            },
          ),
          ListTile(
            trailing: Icon(Icons.dark_mode),
            title: Text(context.translate.dark_mode),
            onTap: () {
              box.write("dark_mode", "true");
              Restart.restartApp();
            },
          ),
        ],
      ),
    );
  }
}
