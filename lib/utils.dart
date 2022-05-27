import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myquran_app/data/data_ayat.dart';
import 'package:myquran_app/data/data_translate.dart';
import 'package:myquran_app/data/translate_terjemah_indo.dart';
import 'data/data_surat.dart';

import 'package:http/http.dart' as http;

Future<List<AyahData>> gettingAyahs(SurahData surahData) async {
  try {
    var surahNum = surahData.number;
    String url = "http://api.alquran.cloud/v1/surah/$surahNum";
    var result = await http.get(Uri.parse(url));
    var resultTranslate = await http.get(Uri.parse(url + "/id.indonesian"));
    var data = jsonDecode(result.body)['data'];
    var dataTranslate = jsonDecode(resultTranslate.body)['data'];

    var ayahsData = data['ayahs'] as List<dynamic>;
    var ayahsTranslateData = dataTranslate['ayahs'] as List<dynamic>;

    List<AyahData> finalAyahs = [];
    for (var ayahI = 0; ayahI < ayahsData.length; ayahI++) {
      var ayah = ayahsData[ayahI];
      var surahTranslates = QuranTranslate(
        translates: {
          TranslateID.indonesia: ayahsTranslateData[ayahI]['text'],
        },
      );
      var ayahData = AyahData.fromJSON(ayah);
      ayahData.translate = surahTranslates;
      finalAyahs.add(ayahData);
    }
    return finalAyahs;
  } catch (e) {
    // print(e);
    throw Exception(e);
  }
}

Future<List<SurahData>> getQuranOnline() async {
  try {
    final response = await http.get(
      Uri.parse("http://api.alquran.cloud/v1/surah"),
    );
    var jsonBody = jsonDecode(response.body);
    var data = jsonBody['data'] as List<dynamic>;
    var surahDatas = <SurahData>[];

    for (var element in data) {
      surahDatas.add(SurahData.fromJSON(element));
    }
    return surahDatas;
  } catch (e) {
    throw Exception(e);
  }
}

Future<AyahData> gettingAyah(int number) async {
  try {
    String url = "http://api.alquran.cloud/v1/ayah/$number";
    var result = await http.get(Uri.parse(url));
    var resultTranslate = await http.get(Uri.parse(url + "/id.indonesian"));
    var data = jsonDecode(result.body)['data'];
    var dataTranslate = jsonDecode(resultTranslate.body)['data'];

    var finalAyah = AyahData.fromJSON(data);
    finalAyah.translate = QuranTranslate(
      translates: {
        TranslateID.indonesia: dataTranslate['text'],
      },
    );

    return finalAyah;
  } catch (e) {
    // print(e);
    throw Exception(e);
  }
}

String removeBasmallahAtStart(AyahData ayahData) {
  if (ayahData.number > 1 &&
      ayahData.numberInSurah == 1 &&
      ayahData.number != 1236) {
    return ayahData.text.substring(39);
  } else {
    return ayahData.text;
  }
}

String convertToArabicNumber(String number) {
  String res = '';

  final arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  for (var element in number.characters) {
    res += arabicNumbers[int.parse(element)];
  }

  return res;
}


class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(baseUrl: 'http://api.alquran.cloud/v1/'),
    );
  }

  static Future<Response> getData(
      {required String url, Options? options}) async {
    return await dio.get(url, options: options);
  }
}


