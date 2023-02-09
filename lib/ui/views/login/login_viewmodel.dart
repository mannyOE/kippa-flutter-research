import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:kippassignment/app/app.locator.dart';
import 'package:kippassignment/app/app.router.dart';
import 'package:kippassignment/models/user.model.dart';
import 'package:kippassignment/services/authentication_service.dart';
import 'package:string_validator/string_validator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:kippassignment/app/app.dialogs.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? passwordValidationFunction(value) {
    if (value != null) {
      if (value.length < 8) {
        return "Password has to be 8 letters";
      }
      return null;
    }
    return null;
  }

  String? validateEmailFunction(value) {
    if (value != null) {
      if (!isEmail(value)) {
        return "Invalid email provided";
      }
      return null;
    }
    return null;
  }

  bool validatePassword(String password) {
    return password.length > 5;
  }

  void loginFunction() async {
    bool result = await _authenticationService
        .logUserIn(UserModel(emailController.text, passwordController.text));

    if (result) {
      bool loggedIn = _authenticationService.userLoggedIn();
      if (loggedIn) {
        _navigationService.replaceWith(Routes.feedView);
      }
    } else {
      _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Problem!',
        description: 'No account found for this email address',
      );
    }
  }

  void goToRegister() {
    _navigationService.replaceWithRegisterView();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
