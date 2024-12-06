import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/dto/location_params.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:dio/dio.dart';

class EntrepriseApi {
  final DioClient _dioClient;

  EntrepriseApi(this._dioClient);

Future<int> addEntreprise(Entreprise entreprise) async {
    try {
      final map = entreprise.toMap();
      
      if (entreprise.picture_file != null) {
        final file = entreprise.picture_file;
        final multipartFile = await MultipartFile.fromFile(
          file!.path, 
          filename: file.path.split('/').last
        );
        map['picture_file'] = multipartFile;
      }

      final formData = FormData.fromMap(map);

      final res = await _dioClient.dio
          .post(Endpoints.addEntreprise, data: formData);
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> addEntreprises(Entreprise entreprise) async {
    try {
      final formData = FormData.fromMap(entreprise.toMap());

      if (entreprise.picture_file != null) {
        final file = entreprise.picture_file;

        final multipartFile = await MultipartFile.fromFile(file!.path, filename: file.path.split('/').last);
        formData.files.add(MapEntry('picture_file', multipartFile));
      }

      final res = await _dioClient.dio
          .post(Endpoints.addEntreprise, data: formData);
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateEntreprise(Entreprise entreprise) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: entreprise.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteEntreprise(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<EntrepriseList> getMyEntreprises() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMyEntreprises);
      return EntrepriseList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> getEntrepriseCode(String moughataaCode) async {
    try {
      final res = await _dioClient.dio.get(
        Endpoints.getEntrepriseCode,
        data: {'code': moughataaCode},
      );

      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Entreprise?> findByLocation(LocationParams params) async {
    try {
      final res = await _dioClient.dio.get(
        Endpoints.getEntrepriseByLocation,
        data: params.toJson(),
      );
      if (res.data == "") return null;

      return Entreprise.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
