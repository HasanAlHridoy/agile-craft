import 'dart:convert';
import 'dart:developer';

import 'package:agile_crafts_task/src/core/database/open_box.dart';
import 'package:agile_crafts_task/src/features/home/model/response/product.dart';

class HiveService {
  // Get Functions
  String? getToken() {
    if (OpenBox.tokenBox.isOpen) {
      final String? data = OpenBox.tokenBox.get('access_token');
      if (data != null) {
        return data;
      } else {
        return null;
      }
    } else {
      return "Box is not open";
    }
  }

  /// Get Product Data
  List<ProductModel>? getProductData() {
    if (OpenBox.productsBox.isOpen) {
      final String? data = OpenBox.productsBox.get('products');
      log("Product Data: $data");
      if (data != null) {
        return ProductModel.fromJsonList(json.decode(data));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // Put Functions
  Future<void> putToken(String token) async {
    if (OpenBox.tokenBox.isOpen) {
      await OpenBox.tokenBox.put('access_token', token);
      log("Token Saved Successfully");
    } else {
      log("Box is not open");
    }
  }
/// save all product data



  /// Save Product Data
  Future<void> putProductData(List<ProductModel> productModel) async {
    if (OpenBox.productsBox.isOpen) {
      await OpenBox.productsBox.put('products', json.encode(ProductModel.toJsonList(productModel)));
      log("Product Data Saved Successfully");
    } else {
      log("Box is not open");
    }
  }
}
