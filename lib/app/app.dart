import 'package:kippassignment/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:kippassignment/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:kippassignment/ui/views/home/home_view.dart';
import 'package:kippassignment/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kippassignment/ui/views/register/register_view.dart';
import 'package:kippassignment/ui/views/feed/feed_view.dart';
import 'package:kippassignment/ui/views/login/login_view.dart';
import 'package:kippassignment/services/authentication_service.dart';
import 'package:kippassignment/services/news_feed_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: FeedView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: NewsFeedService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
