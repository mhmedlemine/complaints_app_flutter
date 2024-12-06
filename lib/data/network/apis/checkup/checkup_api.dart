import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/save_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/start_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_complaint_dto.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:dio/dio.dart';

class CheckupApi {
  final DioClient _dioClient;

  CheckupApi(this._dioClient);

  Future<dynamic> addCheckup(AddCheckupParams checkup) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.addCheckup,
        data: checkup.toJson(),
      );
      if (checkup.status == 'with_infractions') {
        return Summon.fromMap(res.data["data"]);
      } else {
        return Checkup.fromMap(res.data["data"]);
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Checkup?> startCheckup(StartCheckupDto data) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.startCheckup,
        data: data.toJson(),
      );
      if (res.data == "") return null;
      return Checkup.fromMap(res.data['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Checkup> saveProgress(SaveCheckupDto data) async {
    try {
      final formData = FormData.fromMap({
        'deleted_evidence_files[]': data.deleted_evidence_files,
        'notes': data.notes,
      });

      for (var i = 0; i < data.infractions.length; i++) {
        final infraction = data.infractions[i];

        formData.fields.add(MapEntry('infractions[$i][infraction_id]',
            infraction['infraction_id'].toString()));
        formData.fields.add(MapEntry(
            'infractions[$i][notes]', infraction['notes']?.toString() ?? ''));

        final evidenceFiles = infraction['evidence_files'] as List?;
        if (evidenceFiles != null) {
          for (var j = 0; j < evidenceFiles.length; j++) {
            final evidence = evidenceFiles[j];
            if (evidence['file'] != null) {
              final file = evidence['file'] as File;

              final multipartFile = await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last);
              formData.files.add(MapEntry(
                  'infractions[$i][evidence_files][$j][file]', multipartFile));
            }
            if (evidence['file_path'] != null) {
              formData.fields.add(MapEntry(
                'infractions[$i][evidence_files][$j][file_path]',
                evidence['file_path']?.toString() ?? ''));
            }

            formData.fields.add(MapEntry(
                'infractions[$i][evidence_files][$j][file_type]',
                evidence['file_type']?.toString() ?? ''));
            formData.fields.add(MapEntry(
                'infractions[$i][evidence_files][$j][description]',
                evidence['description']?.toString() ?? ''));
          }
        }
      }

      for (var i = 0; i < data.custom_infractions.length; i++) {
        final customInfraction = data.custom_infractions[i];

        formData.fields.add(MapEntry('custom_infractions[$i][text]',
            customInfraction['text'].toString()));
        formData.fields.add(MapEntry('custom_infractions[$i][notes]',
            customInfraction['notes']?.toString() ?? ''));

        final evidenceFiles = customInfraction['evidence_files'] as List?;
        if (evidenceFiles != null) {
          for (var j = 0; j < evidenceFiles.length; j++) {
            final evidence = evidenceFiles[j];
            
            if (evidence['file'] != null) {
              final file = evidence['file'] as File;

              final multipartFile = await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last);

              formData.files.add(MapEntry(
                  'custom_infractions[$i][evidence_files][$j][file]',
                  multipartFile));
            }

            if (evidence['file_path'] != null) {
              formData.fields.add(MapEntry(
                'custom_infractions[$i][evidence_files][$j][file_path]',
                evidence['file_path']?.toString() ?? ''));
            }

            formData.fields.add(MapEntry(
                'custom_infractions[$i][evidence_files][$j][file_type]',
                evidence['file_type']?.toString() ?? ''));
            formData.fields.add(MapEntry(
                'custom_infractions[$i][evidence_files][$j][description]',
                evidence['description']?.toString() ?? ''));
          }
        }
      }

      final res = await _dioClient.dio.post(
        Endpoints.saveCheckup(data.checkupId),
        data: formData,
      );
      return Checkup.fromMap(res.data['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Checkup> submitCheckup(SubmitCheckupDto data) async {
    try {
      final formData = FormData.fromMap({
        'deleted_evidence_files[]': data.deleted_evidence_files,
        'action_taken': data.action_taken,
        'duedate': data.duedate?.toIso8601String(),
        'notes': data.notes,
      });

      for (var i = 0; i < data.infractions.length; i++) {
        final infraction = data.infractions[i];

        formData.fields.add(MapEntry('infractions[$i][infraction_id]',
            infraction['infraction_id'].toString()));
        formData.fields.add(MapEntry(
            'infractions[$i][notes]', infraction['notes']?.toString() ?? ''));

        final evidenceFiles = infraction['evidence_files'] as List?;
        if (evidenceFiles != null) {
          for (var j = 0; j < evidenceFiles.length; j++) {
            final evidence = evidenceFiles[j];
            if (evidence['file'] != null) {
              final file = evidence['file'] as File;

              final multipartFile = await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last);
              formData.files.add(MapEntry(
                  'infractions[$i][evidence_files][$j][file]', multipartFile));
            }
            if (evidence['file_path'] != null) {
              formData.fields.add(MapEntry(
                'infractions[$i][evidence_files][$j][file_path]',
                evidence['file_path']?.toString() ?? ''));
            }

            formData.fields.add(MapEntry(
                'infractions[$i][evidence_files][$j][file_type]',
                evidence['file_type']?.toString() ?? ''));
            formData.fields.add(MapEntry(
                'infractions[$i][evidence_files][$j][description]',
                evidence['description']?.toString() ?? ''));
          }
        }
      }

      for (var i = 0; i < data.custom_infractions.length; i++) {
        final customInfraction = data.custom_infractions[i];

        formData.fields.add(MapEntry('custom_infractions[$i][text]',
            customInfraction['text'].toString()));
        formData.fields.add(MapEntry('custom_infractions[$i][notes]',
            customInfraction['notes']?.toString() ?? ''));

        final evidenceFiles = customInfraction['evidence_files'] as List?;
        if (evidenceFiles != null) {
          for (var j = 0; j < evidenceFiles.length; j++) {
            final evidence = evidenceFiles[j];
            
            if (evidence['file'] != null) {
              final file = evidence['file'] as File;

              final multipartFile = await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last);

              formData.files.add(MapEntry(
                  'custom_infractions[$i][evidence_files][$j][file]',
                  multipartFile));
            }

            if (evidence['file_path'] != null) {
              formData.fields.add(MapEntry(
                'custom_infractions[$i][evidence_files][$j][file_path]',
                evidence['file_path']?.toString() ?? ''));
            }

            formData.fields.add(MapEntry(
                'custom_infractions[$i][evidence_files][$j][file_type]',
                evidence['file_type']?.toString() ?? ''));
            formData.fields.add(MapEntry(
                'custom_infractions[$i][evidence_files][$j][description]',
                evidence['description']?.toString() ?? ''));
          }
        }
      }

      final res = await _dioClient.dio.post(
        Endpoints.submitCheckup(data.checkupId),
        data: formData,
      );
      return Checkup.fromMap(res.data['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> cancelCheckup(int checkupId) async {
    try {
      await _dioClient.dio.post(Endpoints.cancelCheckup(checkupId));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Complaint> submitComplaint(SubmitComplaintDto data) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.submitComplaint, data: data.toJson());
      return Complaint.fromMap(res.data['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateCheckup(Checkup checkup) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: checkup.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteCheckup(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<CheckupList> getMyCheckups() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMyCheckups);
      return CheckupList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  
  Future<SummonList> getMySummons() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMySummons);
      return SummonList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Consumer> addConsumer(Consumer merchant) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.addConsumer, data: merchant.toMap());
      return Consumer.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ConsumerList> searchConsumers(String query) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.searchConsumer, data: {"query": query});
      return ConsumerList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
