class ChucknorrisModel {
  String url;
  String value;
  String iconUrl;
  String createdAt;

  ChucknorrisModel(
      {required this.url,
      required this.value,
      required this.iconUrl,
      required this.createdAt});

  factory ChucknorrisModel.fromJson(Map<String, dynamic> json) {
    return ChucknorrisModel(
        url: json['url'],
        value: json['value'],
        iconUrl: json['icon_url'],
        createdAt: json['created_at']);
  }
}
