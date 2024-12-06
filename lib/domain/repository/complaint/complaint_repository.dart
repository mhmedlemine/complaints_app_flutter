import 'dart:async';

import 'package:complaintsapp/domain/entity/complaint/complaint.dart';

abstract class ComplaintRepository {
  Future<ComplaintList> getComplaints();

  Future<Complaint> findComplaintById(int id);

  Future<int> insert(Complaint complaint);

  Future<int> update(Complaint complaint);

  Future<int> delete(int id);
}
