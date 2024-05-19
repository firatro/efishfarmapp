import 'package:efishfarmapp/services/news_services.dart';
import 'package:flutter/material.dart';

class NewsRiverpod extends ChangeNotifier {
final newsServices = NewsServices();

 getNews() => newsServices.getNews();
}