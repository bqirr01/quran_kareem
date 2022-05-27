import 'package:flutter/material.dart';
import 'package:myquran_app/components/expanded_horizontal.dart';
import 'package:myquran_app/constants.dart';
import 'package:myquran_app/data/data_ayat.dart';
import 'package:myquran_app/data/translate_terjemah_indo.dart';
import 'package:myquran_app/utils.dart';

class AyahListItem extends StatelessWidget {
  final AyahData ayah;
  final bool showNumber;
  const AyahListItem({
    Key? key,
    required this.ayah,
    required this.showNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ExpandedHorizontal(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text.rich(
                  TextSpan(
                    text: removeBasmallahAtStart(ayah),
                    style: const TextStyle(
                      color: Color(0xFF4A7D58),
                      fontSize: 26,
                    ),
                    children: showNumber
                        ? [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        color: blackFadedColor,
                                        borderRadius:
                                            BorderRadius.circular(25),
                                      ),
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: Text(
                                          convertToArabicNumber(
                                            ayah.numberInSurah.toString(),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                        : [],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    ayah.translate?.translates[TranslateID.indonesia] ??
                        "No Translate!",
                    style: const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF5C956B)
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.25, color: Color(0xFF5C956B)),
        ),
      ),
    );
  }
}
