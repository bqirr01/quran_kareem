class SurahData {
  final int number;
  final String name;
  final String nameEng;
  final int ayahsQuantity;
  final String revelationType;

  const SurahData({
    required this.number,
    required this.name,
    required this.nameEng,
    required this.ayahsQuantity,
    required this.revelationType,
  });

  factory SurahData.fromJSON(Map<String, dynamic> theJson) {
    return SurahData(
        number: theJson['number'],
        name: theJson['name'],
        nameEng: theJson['englishName'],
        ayahsQuantity: theJson['numberOfAyahs'],
        revelationType: theJson['revelationType']);
  }
}
