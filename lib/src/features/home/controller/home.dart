import 'dart:async';
import 'dart:developer';

import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/features/home/model/response/product.dart';
import 'package:agile_crafts_task/src/features/home/repository/home.dart';
import 'package:agile_crafts_task/src/shared/custom_snackbar/custom_snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

typedef ProductNotifier = AutoDisposeAsyncNotifierProvider<ProductProvider, List<ProductModel>>;
final productProvider = ProductNotifier(ProductProvider.new);

class ProductProvider extends AutoDisposeAsyncNotifier<List<ProductModel>> {
  List<ProductModel> products = [];
  @override
  FutureOr<List<ProductModel>> build() async {
    final response = await sl<HomeRepository>().fetchProductData();

    response.fold(
      (error) {
        throw Exception(error);
      },
      (success) {
        products = success;
      },
    );
    return products;
  }

}
