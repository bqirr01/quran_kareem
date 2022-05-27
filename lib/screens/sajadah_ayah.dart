import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquran_app/animations/bottomAnimation.dart';
import 'package:myquran_app/screens/sajadah_screen.dart';
import 'package:shimmer/shimmer.dart';


class SajdaAyah extends StatelessWidget {
  final String sajdaAyahs;
  final int juz;
  final int ruku;
  final int manzil;
  final int sajdaNumber;
  final String surahName;
  final String surahEnglishName;
  final String englishNameTranslation;
  final String revelationType;

  SajdaAyah({required this.sajdaAyahs,
    required this.revelationType,
    required this.juz,
    required this.ruku,
    required this.manzil,
    required this.sajdaNumber,
    required this.surahEnglishName,
    required this.englishNameTranslation,
    required this.surahName});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFE8FCE8),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFF5C956B),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => SajadahScreen()));
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              snap: false,

              title: Hero(
                tag: surahEnglishName,
                child: Text(
                  surahEnglishName,
                  style: const TextStyle(
                    color: Color(0xFFE8FCE8),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(5.0),
                width: width,
                height: height * 0.692,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text(
                          "Ayat Sajadah",
                          style: TextStyle(
                              color: Color(0xFF5C956B),
                              fontSize: height * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        sajda( sajdaNumber,sajdaAyahs ),
                        SizedBox(height: 25),
                        sajdaInfo(ruku, juz, manzil, revelationType,
                            sajdaNumber, context),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget sajda(int index, String ayahs) {
    return WidgetAnimator(
      ListTile(
        trailing: CircleAvatar(
          radius: 15,
          backgroundColor: Color(0xFFE8FCE8),
          child: CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF5C956B),
              child: Text(
                index.toString(),
                style: TextStyle(fontSize: 15),
              )),
        ),
        title: Text(ayahs,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 25, color: Color(0xFF5C956B))),
      ),
    );
  }

  Widget flexibleAppBar(BuildContext context, double width, double height) {
    return FlexibleSpaceBar(
        centerTitle: true,
        title: Text(surahEnglishName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25)),
        background: Stack(
          children: <Widget>[
            infoInAppBar(context),
          ],
        ));
  }

  Widget infoInAppBar(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            surahName,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }

  Widget sajdaInfo(int ruku, int juz, int manzil, String relevationType,
      int sajdaIndex, BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFF5C956B),
      highlightColor: Color(0xFFE8FCE8),
      enabled: false,
      child: Column(
        children: <Widget>[
          Text("--- Sajda Info ---\n",
              style: TextStyle(color: Color(0xFF5C956B), fontWeight: FontWeight.bold, fontSize: 15)),
          infoText("Juz", juz.toString(), context),
          infoText("Ruku", ruku.toString(), context),
          infoText("Chapter", revelationType, context),
        ],
      ),
    );
  }

  Widget infoText(String leading, String info, BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          leading + ": ",
          style: TextStyle(color: Colors.black, fontSize: height * 0.025),
        ),
        Text(
          info,
          style: TextStyle(
              color: Colors.black87,
              fontSize: height * 0.025,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

