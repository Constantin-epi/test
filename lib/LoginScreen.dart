import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redditech/utils/Io.dart';
import 'API/login.dart';
import 'utils/Io.dart';
// import 'package:flutter/cupertino.dart';
import 'HomePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: BodyLoginPage());
  }
}

class BodyLoginPage extends StatefulWidget {
  const BodyLoginPage({Key? key}) : super(key: key);

  @override
  _BodyLoginPageState createState() => _BodyLoginPageState();
}

class _BodyLoginPageState extends State<BodyLoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      obscureText: false,
      controller: username,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      controller: password,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      // color: Color(),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          loginPressed(
                  fuckReddit: true,
                  username: username.text,
                  password: password.text)
              .then((String bearer) {
            print(bearer);
            if (bearer == "NULL") {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Login failed!"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              writeToken(bearer);
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Login success!"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          });
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xffff8700),
                Color(0xffff8100),
                Color(0xffff4300),
                Color(0xffed001c),
              ])),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/LogoReddit.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                // usernameField,
                // passwordField,
                loginButon,
                TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: const Text('Debug'),
                    ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  const TextInput({Key? key}) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        obscureText: false,
        controller: this.username,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box_rounded),
            labelText: "Username:"),
      ),
      TextField(
          obscureText: true,
          controller: this.password,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.vpn_key), labelText: "Password:"))
    ]);
  }
}
