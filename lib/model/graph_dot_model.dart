class GraphDotModel {
  final int count;
  final String month;

  GraphDotModel({required this.count, required this.month});

  factory GraphDotModel.fromJson(Map<String, dynamic> json){
    return GraphDotModel(
      count: json["count"],
      month: json["month"]
    );
  }
}