import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kippassignment/app/app.bottomsheets.dart';
import 'package:kippassignment/app/app.dialogs.dart';
import 'package:kippassignment/app/app.locator.dart';
import 'package:kippassignment/app/app.router.dart';
import 'package:kippassignment/models/news.model.dart';
import 'package:kippassignment/models/user.model.dart';
import 'package:kippassignment/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<UserModel>('users_box');
  await Hive.openBox<Article>('news_box');
  await Hive.openBox<bool>('loading_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kippa',
      theme: Theme.of(context).copyWith(
        primaryColor: kcBackgroundColor,
        focusColor: kcPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
      ),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
