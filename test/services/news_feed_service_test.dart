import 'package:flutter_test/flutter_test.dart';
import 'package:kippassignment/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('NewsFeedServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
