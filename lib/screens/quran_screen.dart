import 'package:flutter/material.dart';
import 'package:myquran_app/components/loading_shimmer.dart';
import 'package:myquran_app/components/surah_list.dart';
import 'package:myquran_app/constants.dart';
import 'package:myquran_app/data/data_surat.dart';
import 'package:myquran_app/screens/home_screen.dart';
import 'package:myquran_app/utils.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);
  @override
  _QuranScreenState createState() => _QuranScreenState();
}
class _QuranScreenState extends State<QuranScreen> {
  late List<SurahData> quranSurahs;

  var _gettingState = 1;
  var _searchField = "";
  var _searchedSurahs = <SurahData>[];
  var _activeSearch = false;
  final _searchNode = FocusNode();
  final _searchTextController = TextEditingController();

  Future<void> fetchQuranSurahs() async {
    try {
      setState(() {
        _gettingState = 1;
      });
      quranSurahs = await getQuranOnline();
      setState(() {
        _gettingState = 0;
      });
    } catch (e) {
      setState(() {
        _gettingState = -1;
      });
    }
  }

  void onSearch(String value) {
    _searchField = value;
    var foundedSurahs = quranSurahs.where((element) {
      try {
        var regex = RegExp(
          "(?:$_searchField)",
          caseSensitive: false,
        );
        return regex.hasMatch(element.nameEng);
      } catch (e) {
        return false;
      }
    }).toList();
    setState(() {
      _searchedSurahs = foundedSurahs;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchQuranSurahs();
  }

  Widget bodyBuilding() {
    switch (_gettingState) {
      case 1:
        return loadingWidget;
      case -1:
        return errorWidget;
      default:
        return Column(
          children: [
            Visibility(
              visible: _activeSearch,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                child: TextField(
                  focusNode: _searchNode,
                  controller: _searchTextController,
                  style: const TextStyle(
                    color: Color(0xFF5C956B),
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF5C956B),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _searchField = '';
                          _activeSearch = false;
                          _searchTextController.clear();
                          _searchNode.unfocus();
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFF5C956B),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFD1F1D1),
                    hintText: "Cari Surat",
                    hintStyle: TextStyle(
                      color: Color(0xFF5C956B).withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  onChanged: onSearch,
                ),
              ),
            ),
            Expanded(
              child: SurahList(
                surahs: _searchField.isEmpty ? quranSurahs : _searchedSurahs,
              ),
            ),
          ],
        );
    }
  }

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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _activeSearch = !_activeSearch;
                _activeSearch
                    ? _searchNode.requestFocus()
                    : _searchNode.unfocus();
              });
            },
            icon: const Icon(
              Icons.search,
              color: Color(0xFFD5E4D4),
              semanticLabel: "Search",
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 60,
        title: Text("List Surah",
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

      body: RefreshIndicator(
        onRefresh: () => fetchQuranSurahs(),
        child: bodyBuilding(),
      ),
      );
  }
}