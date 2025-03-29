import 'package:hive_ce_flutter/hive_flutter.dart';



class OpenBox {
  static late Box tokenBox;
  static late Box productsBox;
  static Future<void> openBox() async {

    //init Hive
    await Hive.initFlutter(); 

    //open box
    ///
    tokenBox = await Hive.openBox('token'); 
    ///
    productsBox = await Hive.openBox('products');
  }
}

