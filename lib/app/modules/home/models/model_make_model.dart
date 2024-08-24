class Model {
  final String model;
  final String make;

  Model({
    required this.model,
    required this.make,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      model: json['model'] ??'' as String,
      make: json['make'] ??'' as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'make': make,
    };
  }
}