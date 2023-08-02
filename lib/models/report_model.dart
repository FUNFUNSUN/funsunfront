class ReportModel {
  String type, target, message;

  ReportModel(
      {required this.type, required this.target, required this.message});

  ReportModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        target = json['target'],
        message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['target'] = target;
    data['message'] = message;
    return data;
  }
}
