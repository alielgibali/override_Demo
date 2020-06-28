import 'package:flutter/services.dart';
import 'package:override_todo_demo/helpers/firebase_auth.dart';
import 'package:override_todo_demo/providers/spinner.dart';
import 'package:override_todo_demo/screens/toDo_home.dart';
import 'package:provider/provider.dart';

import '.././widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  void _submitAuthForm(
    String email,
    String userName,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    Provider.of<Loading>(ctx, listen: false).changeLoadingUI();
    AuthResult authResult;
    try {
      if (isLogin) {
        authResult = await FirebaseAuthentication.signIn(email, password);
      } else {
        authResult = await FirebaseAuthentication.signUp(email, password);
      }
      Navigator.of(ctx).pushReplacementNamed(ToDo.routeName);
    } on PlatformException catch (err) {
      Provider.of<Loading>(ctx, listen: false).changeLoadingUI();

      var message = 'An error occured , please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (error) {
      Provider.of<Loading>(ctx, listen: false).changeLoadingUI();
      print(error);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  void _tryWithGoogle(BuildContext context) async {
    AuthResult authResult;
    try {
      authResult = await FirebaseAuthentication.signInWithGoogle();
      if (authResult == null) {
        return;
      }
      Navigator.of(context).pushReplacementNamed(ToDo.routeName);
    } on PlatformException catch (err) {
      throw err;
    } catch (error) {
      print(error);
    }
  }

  void _tryWithFacebook(BuildContext context) async {
    AuthResult authResult;
    try {
      authResult = await FirebaseAuthentication.singInWithFacebook();
      if (authResult == null) {
        return;
      }
      Navigator.of(context).pushReplacementNamed(ToDo.routeName);
    } on PlatformException catch (err) {
      throw err;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitFn: _submitAuthForm,
        tryWithGoogle: _tryWithGoogle,
        tryWithFacebook: _tryWithFacebook,
      ),
    );
  }
}
