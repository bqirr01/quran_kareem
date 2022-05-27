import 'package:flutter/material.dart';
import 'package:myquran_app/screens/quran_screen.dart';
import 'package:myquran_app/screens/sajadah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color(0xFF5C956B),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 273,
                    height: 156,
                    child: Image.asset('assets/images/logo.png')),
                Container(height: 3),
                const Text("Al-Qur'an",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 41, color: Color(
                        0xFFE8FCE8))),

                Padding(
                  padding: const EdgeInsets.only(top: 43),
                  child: SizedBox(
                    width: 305.53,
                    height: 72.37,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE8FCE8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const QuranScreen()));
                      },
                      child: const Text(
                        "Baca Qur'an",
                        style: TextStyle(
                          color: Color(0xFF5C956B),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 19),
                  child: SizedBox(
                    width: 305.53,
                    height: 72.37,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFE8FCE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SajadahScreen()));
                      },
                      child: const Text(
                        "Ayat Sajadah",
                        style: TextStyle(
                          color: Color(0xFF5C956B),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            )
        )
    );
  }
}