class GeneralFilterModel {
  double? minPrice;
  double? maxPrice;
  double? minDistance;
  double? maxDistance;
  double? minTime;
  double? maxTime;

  GeneralFilterModel({
    this.minPrice,
    this.maxPrice,
    this.minDistance,
    this.maxDistance,
    this.minTime,
    this.maxTime,
  });

  factory GeneralFilterModel.fromJson(Map<String, dynamic> json) {
    return GeneralFilterModel(
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      minDistance: json['minDistance'],
      maxDistance: json['maxDistance'],
      minTime: json['minTime'],
      maxTime: json['maxTime'],
    );
  }

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['minDistance'] = this.minDistance;
    data['maxDistance'] = this.maxDistance;
    data['minTime'] = this.minTime;
    data['maxTime'] = this.maxTime;

    return data;
  }
}