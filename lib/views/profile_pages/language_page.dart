import 'package:efishfarmapp/core/extensions/l10n_exntesions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restart_app/restart_app.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.language_settings),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(context.translate.turkish),
            onTap: () {
              box.write("country_code", "tr");
              box.write("country_code_upper", "TR");
              Restart.restartApp();
            },
          ),
          ListTile(
            title: Text(context.translate.english),
            onTap: () {
              box.write("country_code", "en");
              box.write("country_code_upper", "US");
              Restart.restartApp();
            },
          ),
          ListTile(
            title: Text(context.translate.finnish),
            onTap: () {
              box.write("country_code", "fi");
              box.write("country_code_upper", "FI");
              Restart.restartApp();
            },
          ),
        ],
      ),
    );
  }
}
