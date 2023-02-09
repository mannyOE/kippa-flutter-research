import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:kippassignment/app/app.locator.dart';
import 'package:kippassignment/app/app.dialogs.dart';
import 'package:kippassignment/app/app.router.dart';
import 'package:kippassignment/models/user.model.dart';
import 'package:string_validator/string_validator.dart';
import 'package:kippassignment/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
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

  void registerFunction() async {
    bool finished = await _authenticationService
        .createUser(UserModel(emailController.text, passwordController.text));

    if (finished) {
      _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Finished!',
        description: 'Account created. Login to continue',
      );
      goToLogin();
    } else {
      _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Problem!',
        description: 'This account already exists. Login to continue',
      );
    }
  }

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }
}
