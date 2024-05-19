import 'package:efishfarmapp/riverpod/app_riverpod.dart';
import 'package:efishfarmapp/riverpod/farm_riverpod.dart';
import 'package:efishfarmapp/riverpod/login_riverpod.dart';
import 'package:efishfarmapp/riverpod/news_riverpod.dart';
import 'package:efishfarmapp/riverpod/profile_riverpod.dart';
import 'package:efishfarmapp/riverpod/register_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsRiverpod = ChangeNotifierProvider((_) => NewsRiverpod());
final appRiverpod = ChangeNotifierProvider((_) => AppRiverpod());
final registerRiverpod = ChangeNotifierProvider((_) => RegisterRiverpod());
final farmRiverpod = ChangeNotifierProvider((_) => FarmRiverpod());
final profileRiverpod = ChangeNotifierProvider((_) => ProfileRiverpod());
final loginRiverpod = ChangeNotifierProvider((_) => LoginRiverpod());
