import 'dart:async';

import 'package:fittness_1/auth_services.dart';
import 'package:fittness_1/screens/home_screen.dart';
import 'package:fittness_1/screens/signup_screen.dart';
import 'package:fittness_1/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>UserProvider()),
  ],
  child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authservice as = authservice();

  @override
  void initState() {
    super.initState();
    as.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:
        SplashScreen()
      //Provider.of<UserProvider>(context).user.token.isEmpty ? const SignupScreen() : const HomeScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
   State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authservice as = authservice();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2), 
          () {
        as.getUserData(context); 
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Provider.of<UserProvider>(context).user.token.isEmpty
                ? const SignupScreen()
                : const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(child: Column(
        children: [
          Container(
            height: 50,
          ),
          Center(child: Image.asset('asset/images/splash_screen.png',)
          ),
          Container(
            height: 50,
          ),
          Text("U_FIT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 55),
          )
        ],
      )),
    );
  }
}
