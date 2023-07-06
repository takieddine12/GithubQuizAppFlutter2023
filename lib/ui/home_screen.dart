

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/auth_manager.dart';
import 'package:quiz_app/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final List<String> _categories = [
    "Animals","Geography","History"
  ];

  final List<String> _icons = [
    "assets/images/pets.png",
    "assets/images/geography.png",
    "assets/images/history.png",
  ];

  late String email;
  late String displayName;
  late String photoUrl;

  @override
  void initState() {
    super.initState();
    assignValues();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/bg.png",filterQuality: FilterQuality.high,fit: BoxFit.cover,
            height: double.maxFinite,width: double.maxFinite),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.ac_unit,color: Colors.grey.shade200,size: 15,),
                              const SizedBox(width: 10,),
                              Text("Good Morning",style: getStyle().copyWith(fontSize: 15,color: Colors.grey.shade200),)
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(displayName,style: getStyle().copyWith(fontSize: 18),)
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(photoUrl),
                        ),)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color(0xff9087e5)
                  ),
                  child: Column(
                    children: [
                      Text("Featured",style: getStyle().copyWith(fontSize: 20),),
                      const SizedBox(height: 30,),
                      Text('Here we are , a quiz with six challenges to take , get ready and start your quiz',
                        style: getStyle().copyWith(fontSize: 18),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(36),topLeft: Radius.circular(35)),
                      color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("All Quizes",style: getStyle().copyWith(fontSize: 26, color: Colors.black),),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: ListView.builder(
                                itemCount: _categories.length,
                                itemBuilder: (context , index){
                                  return  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.grey.shade300,width: 2),
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: Colors.blueGrey
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Image.asset(_icons[index] , height: 30,width: 30,color: Colors.white,),
                                            ),
                                          ),
                                          const SizedBox(width: 20,),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(_categories[index], style : getStyle().copyWith(fontSize: 22,color: Colors.black)),
                                                Text("Question : 10", style : getStyle().copyWith(fontSize: 16,color: Colors.grey.shade400))
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Get.toNamed("/quiz",arguments: [_categories[index]]);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              margin: const EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey.shade200,
                                                borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: const Icon(Icons.navigate_next,size: 35,color: Colors.white,),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void assignValues()  async {
    GoogleSignInAccount? googleUser = Provider.of<AuthManager>(context).googleAccount;
    setState(() {
      email = googleUser!.email;
      displayName = googleUser.displayName!;
      photoUrl = googleUser.photoUrl!;
    });
    var args = Get.arguments;
    setState(() {
      email = args[0];
      displayName = args[1];
      photoUrl = args[2];
    });
  }
}
