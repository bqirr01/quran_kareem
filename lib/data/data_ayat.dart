import 'package:myquran_app/data/data_sajadah.dart';
import 'package:myquran_app/data/data_translate.dart';

class AyahData {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final DataSajadah sajda;
  QuranTranslate? translate;

  AyahData({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.sajda,
  });

  factory AyahData.fromJSON(Map<String, dynamic> theJson) {
    return AyahData(
      number: theJson['number'],
      text: theJson['text'],
      numberInSurah: theJson['numberInSurah'],
      juz: theJson['juz'],
      sajda: DataSajadah.fromJSON(theJson['sajda']),
    );
  }
}
