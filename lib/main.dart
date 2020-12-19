import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_flutter/firebase_login.dart';
import 'file:///C:/Users/krato/AndroidStudioProjects/web_flutter/lib/view/home/home_screen.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int _currentPage = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: [
            Image.asset(
              'assets/images/foto_perfil.jpeg',
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              'assets/images/anjo.jpeg',
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              'assets/images/normal.jpeg',
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0000FF).withOpacity(0.5),
              Color(0xFF00FFFF).withOpacity(0.5),
            ],
          )),
          child: Center(
            child: Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 25),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Login',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (String email) async {
                        UserCredential _userCredential = await FirebaseLogin()
                            .login(_emailController.text,
                                _passwordController.text);
                        if (_userCredential != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        } else {
                          print('erro');
                        }
                      },
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onSubmitted: (String password) async {
                        UserCredential _userCredential = await FirebaseLogin()
                            .login(_emailController.text,
                                _passwordController.text);
                        if (_userCredential != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        } else {
                          print('erro');
                        }
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        UserCredential _userCredential = await FirebaseLogin()
                            .login(_emailController.text,
                                _passwordController.text);
                        if (_userCredential != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        } else {
                          print('erro');
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text('Enviar'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
