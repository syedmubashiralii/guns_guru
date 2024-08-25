class Consultancy {
  final String name;
  final String description;
  final String price;
  final List<String> documentationRequired;
  final String information;

  Consultancy({
    required this.name,
    required this.description,
    required this.price,
    required this.documentationRequired,
    required this.information,
  });

  factory Consultancy.fromMap(Map<String, dynamic> map) {
    return Consultancy(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      documentationRequired: List<String>.from(map['documentationRequired'] ?? []),
      information: map['information'] ?? '',
    );
  }

  factory Consultancy.fromJson(Map<String, dynamic> json) {
    return Consultancy(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      documentationRequired: List<String>.from(json['documentationRequired'] ?? []),
      information: json['information'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'documentationRequired': documentationRequired,
      'information': information,
    };
  }
}
