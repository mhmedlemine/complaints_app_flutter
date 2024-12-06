import 'dart:async';

import 'package:complaintsapp/domain/entity/complaint/consumer.dart';

abstract class ConsumerRepository {
  Future<ConsumerList> getConsumers();

  Future<Consumer> findConsumerById(int id);

  Future<int> insert(Consumer consumer);

  Future<int> update(Consumer consumer);

  Future<int> delete(int id);
}
