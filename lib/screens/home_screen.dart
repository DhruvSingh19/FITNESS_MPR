import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fittness_1/screens/progress_screen.dart';
import 'package:fittness_1/screens/screen_home.dart';
import 'package:fittness_1/screens/setofquestions.dart';
import 'package:fittness_1/screens/settings_screen.dart';
import 'package:fittness_1/screens/training_screen.dart';
import 'package:fittness_1/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  List<Widget> _screens = [Screen_home(),progress_screen(),training_screen(),settings_screen()];
  int _selectedindex=0;

  void _onpagechanged(int index){
    setState(() {
      _selectedindex=index;
    });
  }

  void _onitemtapped(int selectedindex){
    _pageController.jumpToPage(selectedindex);
  }

  void checkfirsttimelogin () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool flag = pref.getBool('isfirsttimelogin') ?? true ;
    if(flag==true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>setofquestions()));
    }
    else{}
  }

  @override
  void initState() {
    super.initState();
    checkfirsttimelogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: Builder(
            builder: (context) {
              return IconButton(
                iconSize: 30,
                color: Colors.deepPurple.shade100,
                icon: Icon(Icons.menu),
                onPressed: () {
                 Scaffold.of(context).openDrawer();
                },
              );
            }
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
            child: Text("U-FIT",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.deepPurple.shade100),),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,15,0),
              child: IconButton(
                iconSize: 30,
                color: Colors.deepPurple.shade100,
                icon: Icon(Icons.person),
                onPressed: () {  },
              ),
            ),
          ],
        ),

      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.deepPurple,
        color: Colors.deepPurple,
        items: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Container(
              height: 55,
                child: Column(
              children: [
                Icon(Icons.home,color: Colors.deepPurple.shade100,),
                Text("Home",style: TextStyle(color: Colors.deepPurple.shade100),)
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Container(
                height: 55,
                child: Column(
                  children: [
                    Icon(Icons.data_exploration,color: Colors.deepPurple.shade100,),
                    Text("Progress",style: TextStyle(color: Colors.deepPurple.shade100),)
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Container(
                height: 55,
                child: Column(
                  children: [
                    Icon(Icons.sports_gymnastics,color: Colors.deepPurple.shade100,),
                    Text("Training",style: TextStyle(color: Colors.deepPurple.shade100),)
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Container(
                height: 55,
                child: Column(
                  children: [
                    Icon(Icons.settings,color: Colors.deepPurple.shade100,),
                    Text("Settings",style: TextStyle(color: Colors.deepPurple.shade100),)
                  ],
                )),
          ),
        ],
        onTap: _onitemtapped,
      ),

       drawer: Drawer(
          child: Container(
            color: Colors.deepPurple,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(child: Text("U-FIT",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.deepPurple.shade100),)),
                ),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.deepPurple.shade100,size: 40,),
                  title: Text("Home",style: TextStyle(fontSize: 25,color: Colors.deepPurple.shade100),),
                  onTap: (){
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.home,color: Colors.white,),
                //   title: Text("Home",style: TextStyle(fontSize: 20,color: Colors.white),),
                //   onTap: (){
                //
                //   },
                // )
              ],
            ),
          ),
        ),

        body:
        PageView(
              controller: _pageController,
              onPageChanged: _onpagechanged,
              children: _screens,
        )
    );
  }
}