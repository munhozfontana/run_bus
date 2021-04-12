import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('aaaa', () {
    log('log me', name: 'my.app.category', error: 'aaaa', level: 1);
  });
}
