class ProductRequestModel {
  final int tenantId;
  final String name;
  final String description;
  final bool isAvailable;
  final int? id;

  ProductRequestModel({this.tenantId = 10, required this.name, required this.description, required this.isAvailable, this.id });

  Map<String, dynamic> toJson() {
    return { 'tenantId' : tenantId, 'name': name, 'description': description, 'isAvailable': isAvailable, 'id': id };
  }
}
