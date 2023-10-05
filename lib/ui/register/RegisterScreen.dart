import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_route/Database/UsersDao.dart';
import 'package:todo_route/Database/model/User.dart' as MyUser;
import 'package:todo_route/FirebaseErrorCodes.dart';
import 'package:todo_route/ValidationUtilities.dart';
import 'package:todo_route/providers/AuthProvider.dart';
import 'package:todo_route/ui/DialogUtils.dart';
import 'package:todo_route/ui/common/CustomFormField.dart';
import 'package:todo_route/ui/login/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullName = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

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
                    hint: 'Full Name',
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please , Enter This Field';
                      }
                      return null;
                    },
                  controller: fullName,
                ),
                CustomFormField(
                    hint: 'User Name',
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please , Enter User Name';
                      }
                      return null;
                    },
                controller: userName,
                ),
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
                CustomFormField(hint: 'Confirm Password', secureText: true ,
                validator: (text){
                  if (text == null || text.trim().isEmpty) {
                    return 'Please , Enter password';
                  }
                  if(password.text != text){
                    return 'Password not match';
                  }
                  return null;
                },
                  controller: confirmPassword,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      createAccount();
                    },
                    child: Text('Create Account')),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                }, child: Text('Already Have an Account'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount () async {
    // is form not valid
    if(formKey.currentState?.validate() == false){
      return;
    }
    var authProvider = Provider.of<AuthProvider>(context , listen: false); // false cuz we outside Method build
    // if valid -> call register on firebase auth
   try{
      Dialogutils.showLoading(context, 'Loading.....');
     await authProvider.register(email.text, password.text, userName.text, fullName.text);
   //   var result = await FirebaseAuth.instance
   //       .createUserWithEmailAndPassword(
   //       email: email.text,
   //       password: password.text);
   //   // insert user into database
   // await UsersDao.createUser(
   //    MyUser.User(
   //       id : result.user?.uid,
   //      userName: userName.text,
   //      fullName: fullName.text,
   //      email: email.text
   //     )
   //   );
   Dialogutils.hideDialog(context);
     Dialogutils.showMessege(context, 'Registered Successfully' ,
         posActionTitle: 'OK' ,
         posAction: (){
       Navigator.pushReplacementNamed(context, LoginScreen.routeName);
         });
     //print(result.user?.uid);
   }on FirebaseAuthException catch (e) {
     if (e.code == FirebaseErrorCodes.weakPassword) {
       Dialogutils.showMessege(context ,'The password provided is too weak ');
     } else if (e.code == FirebaseErrorCodes.emailInUse) {
       Dialogutils.showMessege(context, 'The account already exists for that email ');
     }
   } catch (e) {     // in general error
     Dialogutils.showMessege(context, 'Something Went Wrong ${e.toString()}');
     //print(e);
   }

  }
}


