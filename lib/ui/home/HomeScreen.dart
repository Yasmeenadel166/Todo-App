
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_route/ui/DialogUtils.dart';
import 'package:todo_route/ui/home/Settings/SettingsTab.dart';
import 'package:todo_route/ui/home/tasksList/TasksListTab.dart';
import 'package:todo_route/ui/login/LoginScreen.dart';

import '../../providers/AuthProvider.dart';

class HomeScreen extends StatefulWidget {
static const routeName ='HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Tasks App'),
        leading: IconButton(
          onPressed: (){
            logout();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12 ,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
          setState(() {
            selectedIndex= index;
          });
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list) , label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings) , label: '')
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  int selectedIndex = 0;

  var tabs =[SettingsTab(), TasksListTab()];

  void logout() {
    var authProvider = Provider.of<AuthProvider>(context , listen: false); // false cuz we outside Method build

    Dialogutils.showMessege(context, 'Are you sure to Logout ?',
    posActionTitle: 'Yes',
      posAction: (){
        authProvider.logout();
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      },
      negActionTitle: 'Cancel',

    );
  }
}
