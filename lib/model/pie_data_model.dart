class PieDataModel {
  final String category;
  final double percent;

  PieDataModel({required this.category, required this.percent});

  PieDataModel.clone(PieDataModel original)
      : category = original.category,
        percent = original.percent;

  factory PieDataModel.fromJson(Map<String, dynamic> json){
    return PieDataModel(
      category: json["category"],
      percent: json["percent"]
    );
  }
}