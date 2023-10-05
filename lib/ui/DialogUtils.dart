
import 'package:flutter/material.dart';


class Dialogutils {

  static void showLoading(BuildContext context , String messege ,
      {bool isCacelable = true}){
  showDialog(
      context: context,
      builder: (BuildContext){
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 10,),
          Text(messege)
        ],
      ),
    );
  },
    barrierDismissible: isCacelable
  );

  }


  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessege(BuildContext context , String messege ,
      {
        String? posActionTitle,
        VoidCallback? posAction,
        String? negActionTitle,
        VoidCallback? negAction,
        bool isCacelable = true}){
    List<Widget> actions =[];
    if(posActionTitle !=null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            posAction?.call();
            },
          child: Text(posActionTitle)));
    }
    if(negActionTitle !=null){
      actions.add(TextButton(
          onPressed: (){Navigator.pop(context); negAction?.call();},
          child: Text(negActionTitle)));
    }
    showDialog(
        context: context,
        builder: (BuildContext){
          return AlertDialog(
            actions: actions,
            content: Row(
              children: [
                Expanded(child: Text(messege))
              ],
            ),
          );
        },
        barrierDismissible: isCacelable
    );

  }


}