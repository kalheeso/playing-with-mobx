import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/controllers/LoginController.dart';
import 'package:todomobx/screens/ListScreen.dart';
import 'package:todomobx/widgets/StandardIconButton.dart';
import 'package:todomobx/widgets/StandardTextField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController _loginController;
  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _loginController = Provider.of<LoginController>(context);

    disposer = reaction((_) => _loginController.loggedIn, (loggedIn) {
      if (loggedIn) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => ListScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(
                      builder: (_) => CustomTextField(
                        hint: "Email",
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: (email) {
                          _loginController.setEmail(email);
                        },
                        enabled: !_loginController.isLoading,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) => CustomTextField(
                        hint: "Password",
                        prefix: Icon(Icons.lock),
                        obscure: _loginController.obscurePassword,
                        onChanged: (password) {
                          _loginController.setPassword(password);
                        },
                        enabled: !_loginController.isLoading,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: _loginController.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onTap: () {
                            _loginController.changeVisibility();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) => SizedBox(
                        height: 44,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: _loginController.isLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text('Login'),
                            color: Theme.of(context).primaryColor,
                            disabledColor:
                                Theme.of(context).primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            onPressed: _loginController.loginPressed),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
