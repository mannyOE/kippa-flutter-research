import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:kippassignment/models/news.model.dart';

class NewsFeedService {
  String apiKey = "7ad604ca29d24895b27feea29777cd47";

  Future<NewsModel> fetchNews(String category) async {
    try {
      var url = Uri.parse(
          'https://newsapi.org/v2/everything?q=$category&from=2023-02-01&pageSize=10&sortBy=publishedAt&apiKey=$apiKey');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var parsedJson = convert.jsonDecode(data);
        var news = NewsModel.fromJson(parsedJson);
        return news;
      } else {
        throw Error();
      }
    } catch (e) {
      throw Error();
    }
  }
}
