
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_route/ui/home/HomeScreen.dart';
import 'package:todo_route/ui/login/LoginScreen.dart';

import '../providers/AuthProvider.dart';

class SplashScreen extends StatelessWidget {
static const String routename = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), (){
      navigate(context);
    });
    return Scaffold(
      body: Container(color: Color(0xFFDFECDB),
         alignment: Alignment.center,
          child:Image.asset('assets/images/logo.png'),
      )
    );
  }

  void navigate(BuildContext context)async {
    var authProvider = Provider.of<AuthProvider>(context , listen:  false); // false cuz we outside Method build
  if(authProvider.isLoggedInBefore()){
   await authProvider.retrieveUserFromDatabase();
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
  else{
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
  }
}
