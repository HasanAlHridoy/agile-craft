import 'dart:developer';

import 'package:agile_crafts_task/src/core/database/open_box.dart';

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

  // Put Functions
  Future<void> putToken(String token) async {
    if (OpenBox.tokenBox.isOpen) {
      await OpenBox.tokenBox.put('access_token', token);
      log("Token Saved Successfully");
    } else {
      log("Box is not open");
    }
  }
}
