import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MainPage.dart';

class LoginScreen extends StatefulWidget
{
  LoginState createState() => LoginState();
}

class LoginState extends State <LoginScreen>
{
  final formKey = new GlobalKey<FormState>();
  String email, password;
  Widget build(BuildContext context)
  {
    return LoginPage(context);
  }

  
  
  
  Widget LoginPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30.0),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
                        "EMAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.redAccent,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'info@Rento.com',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (email) {
                          if (email.isEmpty) {
                            return "Field can\'t be empty";
                          }
                          String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                              "\\@" +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                              "(" +
                              "\\." +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                              ")+";
                          RegExp regExp = new RegExp(p);
                          if (regExp.hasMatch(email)) {
                            // So, the email is valid
                            return null;
                          }
                          return 'Email is not valid';
                        },
                        onSaved: (value) => email = value,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.redAccent,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(
                        validator: (pass) => pass.isEmpty
                            ? 'Password field can\'t be empty'
                            : null,
                        onSaved: (pass) => password = pass,
                        obscureText: true,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '*********',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FlatButton(
                        child: new Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () => dialogTriggerRP(context),
                      ),
                    ],
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.redAccent,
                        onPressed: () {
                          if (validateAndSave()) {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .then((FirebaseUser user) {
                              print("success TO LOGIN");
                              //FirebaseAuth.instance.signOut();
                             Navigator.of(context)..pushReplacement(
                                    MaterialPageRoute(builder: (context)=>MainPage()));
                            }).catchError((e) {
                              print("fail TO LOGIN");
                              print('Error: $e');
                              dialogTriggerEP(context);
                              final snackBar = 
                                new SnackBar(
                                  content:
                                      new Text('Incorrect Email or Password'),
                                );
                              setState(){Scaffold.of(context).showSnackBar(snackBar);
                              }
                            });
                          }
                        },
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "LOGIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('$email & $password');
      return true;
    }
    return false;
  }

    Future<void> dialogTriggerRP(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ResetPassword();
        });
  }

    Widget ResetPassword() {
    final key = new GlobalKey<FormState>();
    return Form(
      key: key,
      child: AlertDialog(
        title: Text('Enter Your Email'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextFormField(
              decoration: new InputDecoration(
                  labelText: 'Email', hintText: 'info@rento.com'),
              validator: (email) {
                if (email.isEmpty) {
                  return "Field can\'t be empty";
                }
                String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                    "\\@" +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                    "(" +
                    "\\." +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                    ")+";
                RegExp regExp = new RegExp(p);
                if (regExp.hasMatch(email)) {
                  // So, the email is valid
                  return null;
                }
                return 'Email is not valid';
              },
              onSaved: (value) => email = value,
            )),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              FirebaseAuth.instance
                  .sendPasswordResetEmail(email: email)
                  .then((user) {
                print("success TO ResetEmail");
                Navigator.of(context).pop();
              }).catchError((e) {
                print("Email Dose Not Exist");
              });
            },
          ),
        ],
      ),
    );
  }

    Future<void> dialogTriggerEP(BuildContext context) async {
    return await showDialog <String>
    (
        context: context,
        builder: (BuildContext context) {
          return wrongEmailorPass();
        });
  }

    Widget wrongEmailorPass() {
    return AlertDialog(
      title: Text('Wrong Email or Password'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }


}
