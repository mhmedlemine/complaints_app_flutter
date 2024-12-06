import 'dart:async';

import 'package:complaintsapp/data/network/apis/complaint/complaint_api.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/repository/complaint/complaint_repository.dart';

class ComplaintRepositoryImpl extends ComplaintRepository {

  // api objects
  final ComplaintApi _complaintApi;

  // constructor
  ComplaintRepositoryImpl(this._complaintApi);

  // Complaint: ---------------------------------------------------------------------
  @override
  Future<ComplaintList> getComplaints() async {
    return await _complaintApi.getMyComplaints().then((complaintsList) {
      return complaintsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Complaint> findComplaintById(int id) {
    return Future.value(Complaint());
  }

  @override
  Future<int> insert(Complaint complaint) async {
    return await _complaintApi.addComplaint(complaint).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Complaint complaint) async {
    return await _complaintApi.updateComplaint(complaint).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _complaintApi.deleteComplaint(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
