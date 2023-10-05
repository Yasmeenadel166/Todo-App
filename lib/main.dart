import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_route/providers/AuthProvider.dart';
import 'package:todo_route/splash/SplashScreen.dart';
import 'package:todo_route/ui/home/HomeScreen.dart';
import 'package:todo_route/ui/login/LoginScreen.dart';
import 'package:todo_route/ui/register/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (buildContext)=>AuthProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,
        primary: Colors.blue
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.white,
              width: 4
            )
          ),
          backgroundColor: Colors.blue
        ),
        scaffoldBackgroundColor: Color(0xFFDFECDB),
        useMaterial3: false,  // cuz the shape of floatingbottom
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName : (_) => RegisterScreen(),
        LoginScreen.routeName : (_) => LoginScreen(),
        HomeScreen.routeName : (_) => HomeScreen(),
        SplashScreen.routename : (_) => SplashScreen(),
      },
      initialRoute: SplashScreen.routename,
    );
  }
}
