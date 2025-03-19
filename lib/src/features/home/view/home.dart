import 'dart:convert';
import 'dart:developer';

import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/core/config/size/size.dart';
import 'package:agile_crafts_task/src/core/network/api_client.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/double.dart';
import 'package:agile_crafts_task/src/features/home/controller/home.dart';
import 'package:agile_crafts_task/src/features/home/model/product.dart';
import 'package:agile_crafts_task/src/features/home/repository/home.dart';
import 'package:agile_crafts_task/src/shared/enum/method.dart';
import 'package:agile_crafts_task/src/shared/riverpod/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});
  static const String name = 'home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(productProvider);
    // final notifier = ref.watch(productProvider.notifier);
    // log(notifier.products.toString());
    return ref
        .watch(productProvider)
        .when(
          error: riverpodError,
          loading: riverpodLoading,
          data: (_) {
            final notifier = ref.watch(productProvider.notifier);
            log(notifier.products.toString());
            return Scaffold(
              body: Column(
                children: [
                  Text('Home', style: context.text.displaySmall),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: notifier.products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(notifier.products[index].name),
                        subtitle: Text(notifier.products[index].description),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
  }
}

// class HomeView extends ConsumerWidget {
//   const HomeView({super.key});
//   static const String name = 'home';
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(productProvider);
//     final notifier = ref.watch(productProvider.notifier);
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             notifier.fetchProductData();
//           },
//           child: Text('Home'),
//         ),
//       ),
//     );
//   }
// }

// // class HomeView extends StatefulWidget {
// //   const HomeView({super.key});
// //   static const String name = 'home';
// //   @override
// //   State<HomeView> createState() => _HomeViewState();
// // }

// // class _HomeViewState extends State<HomeView> {
// //   final ApiClient _apiClient = sl<ApiClient>();
// //   ProductModel? products;
// //   Future<List<ProductModel>> fetchProductData() async {
// //     EasyLoading.show();
// //     final response = await sl<HomeRepository>().fetchProductData();

// //     response.fold(
// //       (error) {
// //         EasyLoading.dismiss();
// //         // CustomSnackbar.show(context, error.toString(), isError: true);
// //       },
// //       (success) {
// //         EasyLoading.dismiss();
// //         products = success;
// //         return products;
// //         // context.pop();
// //       },
// //     );
// //     return [];
// //   }

// //   getData() async {
// //     try {
// //       final response = await _apiClient.request(
// //         ApiClientMethod.get,
// //         'services/app/ProductSync/GetAllproduct',
// //         isAuthRequired: true,
// //       );
// //       final data = ProductModel.fromJsonList(json.decode(response));
// //       // Log the type of response to ensure it's correct
// //       log('Response type: ${data.first.name}');
// //       log('Response type: ${response.runtimeType}');
// //       log('Response content: $response');
// //     } catch (e) {
// //       log('Error: $e');
// //     }
// //   }

// //   @override
// //   void initState() {
// //     getData();
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold(body: Center(child: Text('Home')));
// //   }
// // }
