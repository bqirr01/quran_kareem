import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:myquran_app/constants.dart';
import 'package:myquran_app/data/data_surat.dart';
import 'package:myquran_app/screens/detail_screen.dart';

class SurahListItem extends StatelessWidget {
  final SurahData surahData;
  const SurahListItem({
    Key? key,
    required this.surahData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.black,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(surahData: surahData),
          ),
        );
      },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: blackFadedColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    intl.NumberFormat("00").format(surahData.number),
                    style: const TextStyle(
                      color: Color(0xFFD5E4D4),
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hero(
                        tag: surahData.nameEng,
                        child: Text(
                          surahData.nameEng,
                          style: const TextStyle(
                            color: Color(0xFF4A7D58),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        "${surahData.revelationType} | ${surahData.ayahsQuantity} Ayat",
                        style: TextStyle(
                          color: Color(0xFF5C956B),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    surahData.name,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Color(0xFF4A7D58),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.25, color: Color(0xFF5C956B)),
            ),
          ),
        ),
      );
  }
}
