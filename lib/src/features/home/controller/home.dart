import 'dart:async';
import 'dart:developer';

import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/features/home/model/product.dart';
import 'package:agile_crafts_task/src/features/home/repository/home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ProductNotifier = AsyncNotifierProvider<ProductProvider, List<ProductModel>>;
final productProvider = ProductNotifier(ProductProvider.new);

class ProductProvider extends AsyncNotifier<List<ProductModel>> {
  List<ProductModel> products = [];
  @override
  FutureOr<List<ProductModel>> build() async {
    final response = await sl<HomeRepository>().fetchProductData();

    log('Hasan: $response');
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

  Future<List<ProductModel>> fetchProductData() async {
    EasyLoading.show();
    final response = await sl<HomeRepository>().fetchProductData();

    response.fold(
      (error) {
        EasyLoading.dismiss();
        // CustomSnackbar.show(context, error.toString(), isError: true);
      },
      (success) {
        EasyLoading.dismiss();
        products = success;
        return products;
        // context.pop();
      },
    );
    return [];
  }

  // @override
  // FutureOr<List<ProductModel>> build() {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
}
