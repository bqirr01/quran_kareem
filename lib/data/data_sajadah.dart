class DataSajadah {
  final int id;
  final bool isSajda;
  final bool isRecommended;
  final bool isObligatory;

  DataSajadah({
    required this.id,
    required this.isSajda,
    required this.isRecommended,
    required this.isObligatory
  });

  factory DataSajadah.fromJSON(dynamic data) {
    if (data is bool) {
      return DataSajadah(
        id: -1,
        isSajda: false,
        isRecommended: false,
        isObligatory: false,
      );
    } else {
      return DataSajadah(
        id: data['id'],
        isSajda: true,
        isRecommended: data['recommended'],
        isObligatory: data['obligatory'],
      );
    }
  }
}
