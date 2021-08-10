import 'package:mobx/mobx.dart';
part 'LoginController.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  String email = "";
  @action
  void setEmail(email) => this.email = email;

  @observable
  bool obscurePassword = true;
  @action
  void changeVisibility() => obscurePassword = !obscurePassword;

  @observable
  bool isLoading = false;
  @action
  Future<void> login() async {
    isLoading = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    loggedIn = true;
    email = "";
    password = "";
  }

  @action
  void logout() {
    loggedIn = false;
  }

  @observable
  bool loggedIn = false;

  @observable
  String password = "";
  @action
  void setPassword(password) => this.password = password;

  @computed
  Function get loginPressed =>
      (isEmailValid && isPasswordValid && !isLoading) ? login : null;

  @computed
  bool get isEmailValid =>
      email.contains("mail.com") && email.length > 6 && email.contains("@");

  @computed
  bool get isPasswordValid => password.length > 6 && !password.contains(" ");
}
