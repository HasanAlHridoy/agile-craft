part of 'product.dart';

extension ProductExt on ProductModel {
  //copy with method
  ProductModel copyWith({
    int? tenantId,
    String? name,
    String? description,
    bool? isAvailable,
    int? id,
  }) {
    return ProductModel(
      tenantId ?? this.tenantId,
      name ?? this.name,
      description ?? this.description,
      isAvailable ?? this.isAvailable,
      id ?? this.id,
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      'tenantId': tenantId,
      'name': name,
      'description': description,
      'isAvailable': isAvailable,
      'id': id,
    };
  }
  //to raw json
  String toRawJson() => json.encode(toJson());
}