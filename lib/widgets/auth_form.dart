import 'package:flutter/material.dart';
import 'package:override_todo_demo/helpers/firebase_auth.dart';
import 'package:override_todo_demo/providers/spinner.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AuthForm extends StatefulWidget {
  AuthForm({
    this.submitFn,
    this.tryWithGoogle,
  });
  final void Function(String email, String userName, String password,
      bool isLogin, BuildContext ctx) submitFn;
  final void Function(BuildContext context) tryWithGoogle;
  @override
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  static bool isLoading = false;

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userName.trim(), _userPassword.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<Loading>(context);
    return Stack(
      children: <Widget>[
        Container(
          height: 650,
          child: RotatedBox(
            quarterTurns: 2,
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [Colors.deepPurple, Colors.deepPurple.shade200],
                  [Colors.indigo.shade200, Colors.purple.shade200],
                ],
                durations: [19440, 10800],
                heightPercentages: [0.20, 0.25],
                blur: MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
              waveAmplitude: 0,
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _isLogin ? "Login" : "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0),
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@'))
                            return 'Please enter a valid email address.!';
                          return null;
                        },
                        onSaved: (value) {
                          _userEmail = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black26,
                          ),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.black26,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black26),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                        ),
                      ),
                    ),
                    if (!_isLogin)
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          key: ValueKey('userName'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 4)
                              return 'Please enter at least 4 characters.';
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black26,
                              ),
                              suffixIcon: Icon(
                                Icons.check_circle,
                                color: Colors.black26,
                              ),
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.black26),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextFormField(
                        key: ValueKey('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7)
                            return 'Password must be at least 7 characters long.';
                          return null;
                        },
                        onSaved: (value) {
                          _userPassword = value;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black26,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    if (loading.isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!loading.isLoading)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: Colors.pink,
                          onPressed: _trySubmit,
                          elevation: 11,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    if (!loading.isLoading)
                      Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("or, connect with"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Google"),
                            textColor: Colors.white,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            onPressed: () => widget.tryWithGoogle(context),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Facebook"),
                            textColor: Colors.white,
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                      ],
                    ),
                    _isLogin
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Dont have an account?"),
                              FlatButton(
                                child: Text("Sign up"),
                                textColor: Colors.indigo,
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                              )
                            ],
                          )
                        : FlatButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            textColor: Colors.indigo,
                            child: Text(
                              'Already Have an account',
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
