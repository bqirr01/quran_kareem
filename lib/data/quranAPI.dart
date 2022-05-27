import 'package:http/http.dart' as http;
import 'package:myquran_app/data/data_juz.dart';
import 'dart:async';
import 'dart:convert';

import 'package:myquran_app/data/data_surat.dart';
import 'package:myquran_app/data/sajdaModel.dart';

class QuranAPI {
  Future<SurahData> getSurahList() async {
    String url = "http://api.alquran.cloud/v1/quran/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SurahData.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SajdaList> getSajda() async {
    String url = "http://api.alquran.cloud/v1/sajda/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SajdaList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
}
