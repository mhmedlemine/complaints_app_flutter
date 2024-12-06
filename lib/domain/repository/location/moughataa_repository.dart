import 'dart:async';

import 'package:complaintsapp/domain/entity/location/moughataa.dart';

abstract class MoughataaRepository {
  Future<MoughataaList> getMoughataas();

}
