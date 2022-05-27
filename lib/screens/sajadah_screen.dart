import 'package:flutter/material.dart';
import 'package:myquran_app/animations/bottomAnimation.dart';
import 'package:myquran_app/components/loading_shimmer.dart';
import 'package:myquran_app/data/quranAPI.dart';
import 'package:myquran_app/screens/home_screen.dart';
import 'package:myquran_app/screens/sajadah_ayah.dart';

class SajadahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFE8FCE8),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded), onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => HomeScreen(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 60,
        title: Text("List Sajadah",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFDEF1DE),
            fontSize: 25.45,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
              color: Color(0xFF5C956B),
            )
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: QuranAPI().getSajda(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingShimmer(
                    text: "List Sajadah",
                  );
                } else if (snapshot.hasData == null) {
                  return Center(
                      child: Text(
                          "Koneksi Error! Periksa internet anda"));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        "Ada yang tak beres darimu!\nMenghubungkan kembali :)",
                        textAlign: TextAlign.center,
                      ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Color(0xFF5C956B),
                          height: 0.25,
                        );
                      },
                      itemCount: snapshot.data.sajdaAyahs.length,
                      itemBuilder: (context, index) {
                        return WidgetAnimator(
                          ListTile(
                            onLongPress: () {
                              showDialog(
                                  builder: (context) => SajdaInformation(
                                    juzNumber: snapshot
                                        .data.sajdaAyahs[index].juzNumber,
                                    rukuNumber: snapshot
                                        .data.sajdaAyahs[index].rukuNumber,
                                    sajdaNumber: snapshot
                                        .data.sajdaAyahs[index].sajdaNumber,
                                    surahName: snapshot
                                        .data.sajdaAyahs[index].surahName,
                                    surahEnglishName: snapshot.data
                                        .sajdaAyahs[index].surahEnglishName,
                                    englishNameTranslation: snapshot
                                        .data
                                        .sajdaAyahs[index]
                                        .englishNameTranslation,
                                    revelationType: snapshot
                                        .data.sajdaAyahs[index].revelationType,
                                  ), context: context);
                            },
                            leading: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFF4A7D58)
                              ),
                              child: Text(
                                "${snapshot.data.sajdaAyahs[index].sajdaNumber}",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  color: Color(0xFFD5E4D4),
                                ),
                              ),
                            ),
                            title: Text(
                              "${snapshot.data.sajdaAyahs[index].surahEnglishName}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Color(0xFF5C956B)
                              )
                            ),
                            subtitle: Text(
                              "${snapshot.data.sajdaAyahs[index].englishNameTranslation}",
                            ),
                            trailing: Text(
                              "${snapshot.data.sajdaAyahs[index].surahName}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SajdaAyah(
                                        surahName: snapshot.data
                                            .sajdaAyahs[index].surahName,
                                        surahEnglishName: snapshot
                                            .data
                                            .sajdaAyahs[index]
                                            .surahEnglishName,
                                        englishNameTranslation: snapshot
                                            .data
                                            .sajdaAyahs[index]
                                            .englishNameTranslation,
                                        juz: snapshot.data.sajdaAyahs[index]
                                            .juzNumber,
                                        manzil: snapshot.data
                                            .sajdaAyahs[index].manzilNumber,
                                        ruku: snapshot.data
                                            .sajdaAyahs[index].rukuNumber,
                                        sajdaAyahs: snapshot
                                            .data.sajdaAyahs[index].text,
                                        sajdaNumber: snapshot.data
                                            .sajdaAyahs[index].sajdaNumber,
                                        revelationType: snapshot
                                            .data
                                            .sajdaAyahs[index]
                                            .revelationType,
                                      )));
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                      child:
                      Text("Koneksi Error, Mohon Coba lagi!"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SajdaInformation extends StatefulWidget {
  final int sajdaNumber;
  final String surahName;
  final String surahEnglishName;
  final String englishNameTranslation;
  final int juzNumber;
  final int rukuNumber;
  final String revelationType;

  SajdaInformation(
      {required this.surahName,
        required this.sajdaNumber,
        required this.juzNumber,
        required this.rukuNumber,
        required this.surahEnglishName,
        required this.englishNameTranslation,
        required this.revelationType});

  @override
  _SajdaInformationState createState() => _SajdaInformationState();
}

class _SajdaInformationState extends State<SajdaInformation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                color: Color(0xFF5C956B)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Sajda Information",
                  style: TextStyle( fontWeight: FontWeight.bold, color: Color(0xFFE8FCE8), fontSize: 25)
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        widget.surahEnglishName,
                        softWrap: false,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xFFE8FCE8)
                        ),
                      ),
                    ),
                    SizedBox( width: 25,),

                    Expanded(
                      child: Container(
                        child: Text(
                          widget.surahName,
                          softWrap: false,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFE8FCE8)
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                Text("Sajda Number: ${widget.sajdaNumber}", style: TextStyle(color: Color(0xFFE8FCE8))),
                Text("Juz Number: ${widget.juzNumber}", style: TextStyle(color: Color(0xFFE8FCE8))),
                Text("Ruku Number: ${widget.rukuNumber}", style: TextStyle(color: Color(0xFFE8FCE8))),
                Text("Meaning: ${widget.englishNameTranslation}", style: TextStyle(color: Color(0xFFE8FCE8))),
                Text("Chapter Type: ${widget.revelationType}", style: TextStyle(color: Color(0xFFE8FCE8))),
                SizedBox(
                  height: height * 0.010,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: FlatButton(
                        color: Color(0xFF4A7D58),
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK", style: TextStyle(color: Color(0xFFE8FCE8)),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
