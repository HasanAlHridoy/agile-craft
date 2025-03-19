import 'dart:convert';
part 'product.ext.dart';

class ProductModel {
  final int tenantId;
  final String name;
  final String description;
  final bool isAvailable;
  final int id;

  ProductModel(this.tenantId, this.name, this.description, this.isAvailable, this.id);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json[_Json.tenantId],
      json[_Json.name],
      json[_Json.description],
      json[_Json.isAvailable],
      json[_Json.id],
    );
  }
  // from raw json
  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  // from json list
  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  //to json list
  static List<Map<String, dynamic>> toJsonList(List<ProductModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}

class _Json {
  static const tenantId = 'tenantId';
  static const name = 'name';
  static const description = 'description';
  static const isAvailable = 'isAvailable';
  static const id = 'id';
}
