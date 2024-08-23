class Consultancy {
  final String name;
  final String description;
  final String price;

  Consultancy({required this.name, required this.description,required this.price});

  factory Consultancy.fromMap(Map<String, dynamic> map) {
    return Consultancy(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']
    );
  }
}