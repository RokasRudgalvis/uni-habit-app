import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: Column(
            children: [
   
              
              UserProfile()
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {
    super.initState();

    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(_profile.toString()),
        ),
        Text(_loading.toString()),
      ],
    );
  }
}

class name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData) {
          return MaterialButton(
                onPressed: () => authService.googleSignIn(),
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Login with Google'),
              );
        } else {
          return MaterialButton(
                onPressed: () => authService.signOut(),
                color: Colors.redAccent,
                textColor: Colors.black,
                child: Text('Log out'),
              );
        }
      },
    );
  }
}