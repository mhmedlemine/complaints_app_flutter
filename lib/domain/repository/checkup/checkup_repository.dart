import 'dart:async';

import 'package:complaintsapp/data/network/apis/checkup/dtos/save_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/start_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_complaint_dto.dart';
import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';

abstract class CheckupRepository {
  Future<CheckupList> getCheckups();

  Future<SummonList> getSummons();
  
  Future<CheckupList> getMyComplaintCheckups();

  Future<Checkup> findCheckupById(int id);

  Future<dynamic> insert(AddCheckupParams checkup);
  
  Future<Checkup?> start(StartCheckupDto data);

  Future<Checkup> save(SaveCheckupDto data);

  Future<Checkup> submit(SubmitCheckupDto data);
  
  Future<void> cancel(int checkupId);
  
  Future<Complaint> submitComplaint(SubmitComplaintDto data);
  
  Future<Consumer> addConsumer(Consumer consumer);
  
  Future<ConsumerList> searchConsumers(String query);

  Future<int> update(Checkup checkup);

  Future<int> delete(int id);
}
