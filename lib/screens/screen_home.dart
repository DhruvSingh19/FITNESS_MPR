import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user_provider.dart';

class Screen_home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Screenhomestate();
  }
}

class Screenhomestate extends State<Screen_home>{
  var path_images=['asset/images/fullbody.jpg','asset/images/upperbody.jpg','asset/images/lowerbody.jpg'];
  var challenges_name=['FULL BODY','UPPER BODY','LOWERBODY'];
  var persontype=['BEGINNER','INTERMEDIATE','ADVANCED'];
  var excerise_name=['ABS ','CHEST ','ARM ','LEGS ','SHOULDER AND BACK ',
          'ABS ','CHEST ','ARM ','LEGS','SHOULDER AND BACK ',
          'ABS ','CHEST ','ARM ','LEG ','SHOULDER AND BACK '
  ];
  var use;//to show
  var excerise_time=['10','10','10','10','10','10','10','10','10','10','10','10','10','10','10'];
  var excerise_num = ['15','15','15','15','15','15','15','15','15','15','15','15','15','15','15'];
  int workout=0,kcal=0,minute=0;
  @override
  void initState() {
    super.initState();
    getinstance();
  }

  void getinstance()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    workout=pref.getInt('workout')!;
    kcal=pref.getInt('kcal')!;
    minute=pref.getInt('minute')!;
  }
  @override
  Widget build(BuildContext context) {
    var curr=0;//to show beginner/intermediate/advanced text views
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8.0,0,0),
                    child: Text("Welcome, "+user.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.deepPurple.shade100,
                        child: Column(
                          children: [
                            Text(workout.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                            Text("WORKOUT")
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.deepPurple.shade100,
                        child: Column(
                          children: [
                            Text(kcal.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                            Text("KCAL")
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.deepPurple.shade100,
                        child: Column(
                          children: [
                            Text(minute.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                            Text("MINUTE")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 25,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                  child: Container(
                    height: 25,
                    child: Text("7x4 CHALLENGE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              Container(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: challenges_name.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.transparent, // Transparent color to ensure the image is visible
                                  image: DecorationImage(
                                    image:  AssetImage(
                                      path_images[index].toString(),
                                    ),
                                    fit: BoxFit.cover, // Adjust the image fit as needed
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        challenges_name[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ) ,
                                ),
                              ),


                              SizedBox(
                                height: 10,
                              ),

                              ElevatedButton(
                                onPressed: (){
                                },
                                child: Text("START CHALLENGE",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),


             Container(
               child: SizedBox(
                 height: 2120,
                 width: 420,
                 child: ListView.builder(physics:NeverScrollableScrollPhysics(),
                     itemCount: excerise_name.length,
                     itemBuilder: (context,index){
                   use=index%3;
                   return Column(
                     children: [
                       if(index%5==0)
                         Container(
                           child: Align(
                             alignment: Alignment.topLeft,
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text(persontype[curr++],
                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23)),
                             ),
                           ),
                         ),

                       Container(
                         width: 350,
                         height: 120,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: Colors.transparent, // Transparent color to ensure the image is visible
                           image: DecorationImage(
                             image:  AssetImage(
                               path_images[use].toString(),
                             ),
                             fit: BoxFit.cover, // Adjust the image fit as needed
                           ),
                         ),
                         child: Container(
                           decoration: BoxDecoration(
                             gradient: LinearGradient(
                               begin: Alignment.bottomCenter,
                               end: Alignment.topCenter,
                               colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                             ),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Align(
                               alignment: Alignment.bottomLeft,
                               child: Text(
                                 excerise_name[index]+persontype[curr-1]+"\n"+
                                     excerise_time[index]+" minutes - "+
                                 excerise_num[index]+" excerices",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 20,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                             ),
                           ) ,
                         ),
                       ),
                       SizedBox(
                         height: 10,
                       )
                     ],
                   );
                 }
                                  )
               ),
             ),
             /* Container(
                height: 100,
                color: Colors.blue,
                child: SingleChildScrollView(
                  child: ListView.builder(itemBuilder: (context,index){
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent, // Transparent color to ensure the image is visible
                        image: DecorationImage(
                          image:  AssetImage(
                            path_images[index].toString(),
                          ),
                          fit: BoxFit.cover, // Adjust the image fit as needed
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              challenges_name[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ) ,
                      ),
                    );
                }
                    ),
                  ),
              ),*/


            ],
          ),
        ),
      ),
    );
  }

}