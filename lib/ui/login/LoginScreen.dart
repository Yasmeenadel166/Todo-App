import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_route/Database/UsersDao.dart';
import 'package:todo_route/FirebaseErrorCodes.dart';
import 'package:todo_route/ValidationUtilities.dart';
import 'package:todo_route/ui/DialogUtils.dart';
import 'package:todo_route/ui/common/CustomFormField.dart';
import 'package:todo_route/ui/home/HomeScreen.dart';
import 'package:todo_route/ui/register/RegisterScreen.dart';

import '../../providers/AuthProvider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/icon_check.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CustomFormField(
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please , Enter Email';
                      }
                      if(isValidEmail(text) == false){
                        return 'email bad Format';
                      }
                      return null;
                    },
                controller: email,
                ),
                CustomFormField(hint: 'Password', secureText: true ,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please , Enter password';
                      }
                      if(text.length < 6){
                        return 'Password should be at least 6 chars';
                      }
                      return null;
                    },
                controller: password,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text('Login')),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                }, child: Text('Create New Account'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async{
    // is form valid or not
    if(formKey.currentState?.validate() == false){
      return;
    }
    var authProvider = Provider.of<AuthProvider>(context , listen: false); // false cuz we outside Method build

    try {
      Dialogutils.showLoading(context, 'Loading.....' , isCacelable:  false);
      await authProvider.login(email.text, password.text);
      // final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: email.text,
      //     password: password.text
      // );
      // var user = await UsersDao.getUser(result.user!.uid);
      Dialogutils.hideDialog(context);
      Dialogutils.showMessege(context, 'You logged in Successfully , User ID = '
          // '${result.user?.uid}'
        , posActionTitle: 'OK',
        posAction: (){
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        //negActionTitle: 'No'
      );
      //print(result.user?.uid);  // will print in case login
    } on FirebaseAuthException catch (e) {
      Dialogutils.hideDialog(context);
      print(e.code);
      if (e.code == FirebaseErrorCodes.userNotFound ||
          e.code == FirebaseErrorCodes.wrongPassword ||
          e.code == FirebaseErrorCodes.invalidLoginCredentials
      ) {
        Dialogutils.showMessege(context, 'Wrong Email or password' ,
        posActionTitle: 'OK'
        );
      //  print('Wrong Email or password');
      }
    }
  }
}


