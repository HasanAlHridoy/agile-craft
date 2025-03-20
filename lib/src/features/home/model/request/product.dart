class ProductRequestModel {
  final String name;
  final String description;
  final bool isAvailable;

  ProductRequestModel({required this.name, required this.description, required this.isAvailable});

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'isAvailable': isAvailable};
  }
}
