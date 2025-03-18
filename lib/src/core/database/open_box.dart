import 'package:hive_ce_flutter/hive_flutter.dart';



class OpenBox {
  static late Box tokenBox;
  static Future<void> openBox() async {
    await Hive.initFlutter(); 
    tokenBox = await Hive.openBox('token'); 
  }
}

