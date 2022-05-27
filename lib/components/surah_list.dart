import 'package:flutter/material.dart';
import 'package:myquran_app/components/surah_list_item.dart';
import 'package:myquran_app/data/data_surat.dart';

class SurahList extends StatelessWidget {
  final List<SurahData> surahs;

  const SurahList({
    Key? key,
    required this.surahs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      clipBehavior: Clip.antiAlias,
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SurahListItem(surahData: surahs[index]),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10.0);
      },
    );
  }
}
