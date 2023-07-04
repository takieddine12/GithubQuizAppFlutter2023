import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final List<String> _categories = ["Sports","Science","Actors","Animals","Geography","History"];
  late SharedPreferences _sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.indigo
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text("Select Category",textAlign: TextAlign.center,style: getStyle().copyWith(fontSize: 20),),
              ),
            ),
            Positioned(
              top: 40,
              bottom: 40,
              child:  Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red
                  ),
                  child: GridView.builder(
                      itemCount: _categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0.5,
                          crossAxisSpacing: 0.5
                      ),
                      itemBuilder: (context , index){
                        return GestureDetector(
                          onTap: () {
                            _sharedPreferences.setString("category", _categories[index]);
                            Get.offNamed("/home");
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.indigo
                            ),
                            child: Center(
                              child: Text(_categories[index],style: getStyle().copyWith(fontSize: 20),),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}


/*

 */

/*

 */