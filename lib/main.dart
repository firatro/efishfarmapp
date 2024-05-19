import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_assets.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/firebase_options.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/auth_pages/login_page.dart';
import 'package:efishfarmapp/views/other_pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: box.read('country_code') == null
          ? AppLocalizations.supportedLocales
          : <Locale>[
              Locale(box.read('country_code'), box.read('country_code_upper'))
            ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        /// [locale]: Cihazın dili null değilse
        if (locale != null) {
          log("Algılanan cihaz dili: Dil Kodu: ${locale.languageCode}, Ülke Kodu: ${locale.countryCode}");

          /// for döngüsü yardımıyla [supportedLocales] listesi içinde arama yapıyoruz
          for (var supportedLocale in supportedLocales) {
            /// Cihazın dil kodu [locale.languageCode] ve ülke kodu [locale.countryCode]
            /// desteklenen diller arasındaki dil ve ülke kodlarının içinde [supportedLocale] var mı?
            if (supportedLocale.languageCode == locale.languageCode &&
                locale.countryCode == locale.countryCode) {
              /// Varsa desteklenen dili döndür
              return supportedLocale;
            }
          }
        }
        log("Algılanan cihaz dili desteklenen diller arasında bulunmuyor.");

        /// Yoksa [supportedLocales] Listesindeki ilk sonucu döndür.
        log("Uygulamanın başlatılması istenen dil: Dil Kodu: ${supportedLocales.first.languageCode}, Ülke Kodu: ${supportedLocales.first.countryCode}");
        return supportedLocales.first;
      },
      navigatorKey: Grock.navigationKey,
      title: 'E-Fish Farm',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (ref.read(registerRiverpod).dbServices.user == null) {
          Grock.to(const LoginPage());
        } else {
          Grock.to(const LandingPage());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.5,
              child: AppAssets.appLogo,
            ),
            Text(
              "E-Fish Farm",
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: AppColors.white,
                fontSize: size.width * 0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
