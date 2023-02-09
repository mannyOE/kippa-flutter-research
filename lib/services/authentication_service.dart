import 'package:hive_flutter/hive_flutter.dart';
import 'package:kippassignment/models/user.model.dart';

class AuthenticationService {
  bool userLoggedIn() {
    Box<UserModel> db = Hive.box('users_box');
    UserModel? currentUser = db.get('current_user');
    if (currentUser == null) {
      return false;
    }
    return true;
  }

  Future<bool> logUserIn(UserModel user) async {
    Box<UserModel> db = Hive.box('users_box');
    UserModel? item = db.get(user.email);
    if (item == null) {
      return false;
    } else {
      await db.put("current_user", user);
      return true;
    }
  }

  Future<bool> logUserOut() async {
    Box<UserModel> db = Hive.box('users_box');
    UserModel? item = db.get("current_user");
    if (item == null) {
      return false;
    } else {
      await db.delete("current_user");
      return true;
    }
  }

  Future<bool> createUser(UserModel user) async {
    Box<UserModel> db = Hive.box('users_box');
    UserModel? item = db.get(user.email);
    if (item == null) {
      // create user
      await db.put(user.email, user);
      return true;
    } else {
      return false;
    }
  }
}
