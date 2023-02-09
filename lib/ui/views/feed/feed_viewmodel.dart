// ignore_for_file: prefer_final_fields

import 'package:hive/hive.dart';
import 'package:kippassignment/models/news.model.dart';
import 'package:stacked/stacked.dart';
import 'package:kippassignment/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kippassignment/services/authentication_service.dart';
import 'package:kippassignment/app/app.locator.dart';
import 'package:kippassignment/services/news_feed_service.dart';

class FeedViewModel extends BaseViewModel {
  final _newsService = locator<NewsFeedService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  String _currentCategory = "Africa";
  Box<Article> box = Hive.box("news_box");
  Box<bool> loader = Hive.box("loading_box");
  Iterable<Article> get news => box.values;
  String get currentCategory => _currentCategory;

  List<String> categories = ["Africa", "Business", "Startup"];

  bool? get isLoading => loader.get("loading");

  Future<void> fetchNews(String category) async {
    try {
      loader.put("loading", true);
      _currentCategory = category;
      NewsModel nws = await _newsService.fetchNews(category);
      await box.clear();
      for (var element in nws.articles) {
        box.add(element);
      }
      loader.put("loading", false);
    } catch (e) {
      loader.put("loading", false);
    }
  }

  Future<void> logOut() async {
    await _authenticationService.logUserOut();
    _navigationService.navigateToLoginView();
  }
}
