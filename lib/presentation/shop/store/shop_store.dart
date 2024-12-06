import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/domain/usecase/shop/add_entreprise_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/add_merchant_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_entreprise_code_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_merchant_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_moughataas_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_my_entreprises_usecase.dart';
import 'package:complaintsapp/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'shop_store.g.dart';

class ShopStore = _ShopStore with _$ShopStore;

abstract class _ShopStore with Store {
  // constructor:---------------------------------------------------------------
  _ShopStore(
    this.errorStore,
    this._getEntrepriseUseCase,
    this._getMoughataasUseCase,
    this._addEntrepriseUseCase,
    this._addMerchantUsecase,
    this._getMerchantUseCase,
    this._getEntrepriseCodeUseCase,
  );

  // use cases:-----------------------------------------------------------------
  final GetMyEntreprisesUseCase _getEntrepriseUseCase;
  final GetEntrepriseCodeUseCase _getEntrepriseCodeUseCase;
  final GetMoughataasUseCase _getMoughataasUseCase;
  final AddEntrepriseUsecase _addEntrepriseUseCase;
  final AddMerchantUsecase _addMerchantUsecase;
  final GetMerchantUseCase _getMerchantUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<MoughataaList?> emptyMoughataaResponse =
      ObservableFuture.value(null);

  static ObservableFuture<EntrepriseList?> emptyEntrepriseResponse =
      ObservableFuture.value(null);

  static ObservableFuture<String> emptyEntrepriseCodeResponse =
      ObservableFuture.value("");

  static ObservableFuture<MerchantList?> emptyMerchantsResponse =
      ObservableFuture.value(null);

  static ObservableFuture<int?> emptyAddingEntrepriseResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<MoughataaList?> fetchMoughataasFuture =
      ObservableFuture<MoughataaList?>(emptyMoughataaResponse);

  @observable
  ObservableFuture<EntrepriseList?> fetchEntreprisesFuture =
      ObservableFuture<EntrepriseList?>(emptyEntrepriseResponse);

  @observable
  ObservableFuture<String> fetchEntrepriseCodeFuture =
      ObservableFuture<String>(emptyEntrepriseCodeResponse);

  @observable
  ObservableFuture<MerchantList?> fetchMerchantsFuture =
      ObservableFuture<MerchantList?>(emptyMerchantsResponse);

  @observable
  ObservableFuture<int?> addingEntrepriseFuture =
      ObservableFuture<int?>(emptyAddingEntrepriseResponse);

  @observable
  MoughataaList? moughataaList;

  @observable
  EntrepriseList? entrepriseList;

  @observable
  String entrepriseCode = "";

  @observable
  MerchantList? merchantList;

  @observable
  bool success = false;

  @computed
  bool get loading =>
      fetchMoughataasFuture.status == FutureStatus.pending ||
      fetchEntrepriseCodeFuture.status == FutureStatus.pending ||
      fetchMerchantsFuture.status == FutureStatus.pending ||
      fetchEntreprisesFuture.status == FutureStatus.pending ||
      addingEntrepriseFuture.status == FutureStatus.pending;

  @observable
  bool loadingMerchant = false;

  @observable
  bool addingMerchant = false;

  @observable
  bool addingEntreprise = false;

  // actions:-------------------------------------------------------------------
  @action
  Future getMoughataas() async {
    final future = _getMoughataasUseCase.call(params: null);
    fetchMoughataasFuture = ObservableFuture(future);

    future.then((moughataaList) {
      this.moughataaList = moughataaList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future addEntreprise(Entreprise entreprise) async {
    try {
      addingEntreprise = true;
      final res = await _addEntrepriseUseCase.call(params: entreprise);
      addingEntreprise = false;
      return res;
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      addingEntreprise = false;
      throw error;
    }
  }

  @action
  Future addMerchant(Merchant merchant) async {
    //addingEntrepriseFuture = ObservableFuture(future);

    try {
      addingMerchant = true;
      final res = await _addMerchantUsecase.call(params: merchant);
      addingMerchant = false;
      return res;
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      addingMerchant = false;
      throw error;
    }
  }

  @action
  Future<List<Merchant>?> getMerchant(String query) async {
    loadingMerchant = true;
    try {
      this.merchantList = await _getMerchantUseCase.call(params: query);
      return this.merchantList?.merchants;
    } catch (error) {
      errorStore.errorMessage =
          DioExceptionUtil.handleError(error as DioException);
      return <Merchant>[];
    }
  }

  @action
  Future getMyEntreprises() async {
    final future = _getEntrepriseUseCase.call(params: null);
    fetchEntreprisesFuture = ObservableFuture(future);

    future.then((entrepriseList) {
      this.entrepriseList = entrepriseList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @observable
  bool gettingEntrepriseCode = false;

  @action
  Future getEntrepriseCode(String moughataaCode) async {    
    try {
      gettingEntrepriseCode = true;
      final code = await _getEntrepriseCodeUseCase.call(params: moughataaCode);
      this.entrepriseCode = code;
      gettingEntrepriseCode = false;
      return code;
    } catch (e) {
      gettingEntrepriseCode = false;
      errorStore.errorMessage = DioExceptionUtil.handleError(e as DioException);
      return "";
    }
  }
}
