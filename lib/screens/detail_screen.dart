import 'package:flutter/material.dart';
import 'package:myquran_app/components/ayah_list_item.dart';
import 'package:myquran_app/constants.dart';
import 'package:myquran_app/data/data_ayat.dart';
import 'package:myquran_app/data/data_surat.dart';
import 'package:myquran_app/screens/quran_screen.dart';
import 'package:myquran_app/utils.dart';

class DetailScreen extends StatefulWidget {
  final SurahData surahData;
  const DetailScreen({Key? key, required this.surahData}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<AyahData> surahAyahs = [];
  AyahData? basmallah;
  var gettingState = 1;

  Future<void> fetchAyahs() async {
    try {
      setState(() {
        gettingState = 1;
      });
      surahAyahs = await gettingAyahs(widget.surahData);
      switch (surahAyahs[0].number) {
        case 1:
          break;
        case 1236:
          break;
        default:
          basmallah = await gettingAyah(1);
      }
      setState(() {
        gettingState = 0;
      });
    } catch (e) {
      setState(() {
        gettingState = -1;
      });
    }
  }

  Widget bodyBuilding() {
    switch (gettingState) {
      case 1:
        return const SliverFillRemaining(child: loadingWidget);
      case -1:
        return SliverFillRemaining(child: errorWidget);
      default:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return basmallah != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        child: AyahListItem(
                          ayah: basmallah!,
                          showNumber: false,
                        ),
                      )
                    : const SizedBox(height: 10.0);
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      AyahListItem(
                        ayah: surahAyahs[index - 1],
                        showNumber: true,
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                );
              }
            },
            childCount: surahAyahs.length,
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    fetchAyahs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8FCE8),
      body: RefreshIndicator(
        onRefresh: fetchAyahs,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => QuranScreen()));
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              backgroundColor: Color(0xFF5C956B),
              centerTitle: true,
              floating: true,
              pinned: false,
              snap: false,
              title: Hero(
                tag: widget.surahData.nameEng,
                child: Text(
                  widget.surahData.nameEng,
                  style: const TextStyle(
                    color: Color(0xFFD5E4D4),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            bodyBuilding(),
          ],
        ),
      ),
    );
  }
}
