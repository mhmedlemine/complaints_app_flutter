import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/save_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/start_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_complaint_dto.dart';
import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
import 'package:complaintsapp/domain/dto/location_params.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/entity/complaint/infraction.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/usecase/checkup/add_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/add_consumer_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/cancel_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_consumer_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_entreprise_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_infractions_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_my_checkups_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_my_complaints_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_my_summons_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/save_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/start_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/submit_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/submit_complaint_usecase.dart';
import 'package:complaintsapp/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'checkup_store.g.dart';

class CheckupStore = _CheckupStore with _$CheckupStore;

abstract class _CheckupStore with Store {
  // constructor:---------------------------------------------------------------
  _CheckupStore(
    this.errorStore,
    this._startCheckupUseCase,
    this._saveCheckupUseCase,
    this._submitCheckupUseCase,
    this._cancelCheckupUseCase,
    this._submitComplaintUsecase,
    this._getCheckupUseCase,
    this._getSummonUseCase,
    this._getInfractionsUseCase,
    this._addCheckupUseCase,
    this._getMyComplaintsUseCase,
    this._getEntrepriseUseCase,
    this._addConsumerUsecase,
    this._getConsumerUseCase,
  );

  // use cases:-----------------------------------------------------------------
  final StartCheckupUsecase _startCheckupUseCase;
  final SaveCheckupUsecase _saveCheckupUseCase;
  final SubmitCheckupUsecase _submitCheckupUseCase;
  final CancelCheckupUsecase _cancelCheckupUseCase;
  final SubmitComplaintUsecase _submitComplaintUsecase;
  final AddConsumerUsecase _addConsumerUsecase;
  final GetConsumerUseCase _getConsumerUseCase;

  final GetMyCheckupsUseCase _getCheckupUseCase;
  final GetMySummonsUseCase _getSummonUseCase;
  final GetInfractionsUseCase _getInfractionsUseCase;
  final AddCheckupUsecase _addCheckupUseCase;
  final GetMyComplaintCheckupsUseCase _getMyComplaintsUseCase;
  final GetEntrepriseUseCase _getEntrepriseUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<CheckupList?> emptyCheckupResponse =
      ObservableFuture.value(null);

  static ObservableFuture<SummonList?> emptySummonResponse =
      ObservableFuture.value(null);

  static ObservableFuture<InfractionList?> emptyInfractionsResponse =
      ObservableFuture.value(null);

  static ObservableFuture<dynamic> emptyAddingCheckupResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<CheckupList?> fetchCheckupsFuture =
      ObservableFuture<CheckupList?>(emptyCheckupResponse);

  @observable
  ObservableFuture<SummonList?> fetchSummonsFuture =
      ObservableFuture<SummonList?>(emptySummonResponse);

  @observable
  ObservableFuture<InfractionList?> fetchInfractionsFuture =
      ObservableFuture<InfractionList?>(emptyInfractionsResponse);

  @observable
  ObservableFuture<dynamic> addingCheckupFuture =
      ObservableFuture<dynamic>(emptyAddingCheckupResponse);

  @observable
  Checkup? currentCheckup;

  @observable
  Entreprise? entreprise;

  @observable
  InfractionList? infractionsList;

  @observable
  CheckupList? checkupList;

  @observable
  SummonList? summonList;

  @observable
  CheckupList? complaintCheckupList;

  @observable
  bool success = false;

  @computed
  bool get loading =>
      fetchInfractionsFuture.status == FutureStatus.pending ||
      fetchCheckupsFuture.status == FutureStatus.pending ||
      fetchSummonsFuture.status == FutureStatus.pending ||
      addingCheckupFuture.status == FutureStatus.pending;

  @observable
  bool addingCheckup = false;

  @observable
  bool loadingEntreprise = false;

  // actions:-------------------------------------------------------------------
  @action
  Future getInfractions() async {
    final future = _getInfractionsUseCase.call(params: null);
    fetchInfractionsFuture = ObservableFuture(future);

    future.then((res) {
      this.infractionsList = res;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future<void> startCheckup({
    required String type,
    required double lat,
    required double lon,
  }) async {
    try {
      addingCheckup = true;
      final params = StartCheckupDto(
        type: type,
        lat: lat,
        lon: lon,
      );
      currentCheckup = await _startCheckupUseCase.call(params: params);
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      throw error;
    } finally {
      addingCheckup = false;
    }
  }

  @action
  Future<void> saveCheckupProgress(
      {required int checkupId,
      String? notes,
      required List<Map<String, dynamic>> infractions,
      required List<Map<String, dynamic>> custom_infractions,
      required List<String> deleted_evidence_files}) async {
    try {
      addingCheckup = true;
      final params = SaveCheckupDto(
        checkupId: checkupId,
        notes: notes,
        infractions: infractions,
        custom_infractions: custom_infractions,
        deleted_evidence_files: deleted_evidence_files,
      );
      currentCheckup = await _saveCheckupUseCase.call(params: params);
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      throw error;
    } finally {
      addingCheckup = false;
    }
  }

  @action
  Future<void> submitCheckup({
    required int checkupId,
    String? notes,
    required List<Map<String, dynamic>> infractions,
    required List<Map<String, dynamic>> custom_infractions,
    required List<String> deleted_evidence_files,
    DateTime? duedate,
    required String action_taken,
  }) async {
    try {
      addingCheckup = true;
      final params = SubmitCheckupDto(
        checkupId: checkupId,
        notes: notes,
        infractions: infractions,
        custom_infractions: custom_infractions,
        deleted_evidence_files: deleted_evidence_files,
        duedate: duedate,
        action_taken: action_taken,
      );
      currentCheckup = await _submitCheckupUseCase.call(params: params);

      await getMyCheckups();
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      throw error;
    } finally {
      addingCheckup = false;
    }
  }

  @action
  Future<void> cancelCheckup({required int checkupId}) async {
    try {
      addingCheckup = true;
      await _cancelCheckupUseCase.call(params: checkupId);

      await getMyCheckups();
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      throw error;
    } finally {
      addingCheckup = false;
    }
  }

  @action
  Future addCheckup(AddCheckupParams params) async {
    try {
      addingCheckup = true;
      final res = await _addCheckupUseCase.call(params: params);
      addingCheckup = false;
      return res;
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      addingCheckup = false;
      throw error;
    }
  }

  @action
  Future<Entreprise?> getEntreprise(double lat, double lon) async {
    loadingEntreprise = true;
    try {
      this.entreprise = await _getEntrepriseUseCase.call(
          params: LocationParams(lat: lat, lon: lon));
      return this.entreprise;
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      return null;
    }
  }

  @action
  Future getMyCheckups() async {
    final future = _getCheckupUseCase.call(params: null);
    fetchCheckupsFuture = ObservableFuture(future);

    future.then((checkupList) {
      this.checkupList = checkupList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future getMySummons() async {
    final future = _getSummonUseCase.call(params: null);
    fetchSummonsFuture = ObservableFuture(future);

    future.then((summonList) {
      this.summonList = summonList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future getMyComplaintCheckups() async {
    final future = _getMyComplaintsUseCase.call(params: null);
    fetchCheckupsFuture = ObservableFuture(future);

    future.then((checkupList) {
      this.complaintCheckupList = checkupList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

    @observable
    bool loadingComplaints = false;
    @action
  Future<void> submitComplaint({
    required String title,
    required String description,
    required String greenNumber,
    required int consumerId,
    required String shopAddress,
    required Map<int, bool> selectedInfractions,
    required Map<int, String> infractionNotes,
    required List<Map<String, dynamic>> customInfractions,
  }) async {
    loadingComplaints = true;
    try {
      final complaint = Complaint(
        title: title,
        description: description,
        greenNumber: greenNumber,
        consumer_id: consumerId,
        shop_address: shopAddress,
        reported_at: DateTime.now(),
        status: 'pending',
      );

      await _submitComplaintUsecase.call(
        params: SubmitComplaintDto(
          complaint: complaint,
          selectedInfractions: selectedInfractions,
          infractionNotes: infractionNotes,
          customInfractions: customInfractions,
        ),
      );
      
      success = true;
      loadingComplaints = false;
    } catch (e) {
      loadingComplaints = false;
      success = false;
      throw e;
    }
  }

  @observable
  bool loadingConsumer = false;

  @action
  Future<Consumer> addConsumer(Consumer consumer) async {
    loadingConsumer = true;
    try {
      final result = await _addConsumerUsecase.call(params: consumer);
      loadingConsumer = false;
      return result;
    } catch (e) {
      loadingConsumer = false;
      throw e;
    }
  }

  @action
  Future<ConsumerList> searchConsumers(String query) async {
    loadingConsumer = true;
    try {
      final results = await _getConsumerUseCase.call(params: query);
      loadingConsumer = false;
      return results;
    } catch (e) {
      loadingConsumer = false;
      throw e;
    }
  }
}
