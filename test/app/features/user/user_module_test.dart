import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import 'package:tabnews_app/app/features/user/user_module.dart';

void main() {
  setUpAll(() {
    initModule(UserModule());
  });
}
