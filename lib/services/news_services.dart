import "dart:developer";

import "package:dio/dio.dart";
import "package:efishfarmapp/models/news_model.dart";

class NewsServices {
  final String baseUrl = "https://api.thenewsapi.com/v1/news/all?api_token=hNPb3Htuwm2mI9MB9CRoCIs1vHIQzY3MjhuZDqDb&language=en&limit=3&search=Aquaculture";
  final dio = Dio();
  Future<NewsModel> getNews() async {
    var response = await dio.get(baseUrl);

    if (response.statusCode== 200) {
      var result = NewsModel.fromJson(response.data);
      log(response.data["data"][0]["title"].toString());
      return result;
    } else {
      throw("Bir sorun oluştu ${response.statusMessage}");
    }
  }
}
