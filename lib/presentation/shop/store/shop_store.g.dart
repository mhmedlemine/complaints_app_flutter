// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShopStore on _ShopStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ShopStore.loading'))
      .value;

  late final _$fetchMoughataasFutureAtom =
      Atom(name: '_ShopStore.fetchMoughataasFuture', context: context);

  @override
  ObservableFuture<MoughataaList?> get fetchMoughataasFuture {
    _$fetchMoughataasFutureAtom.reportRead();
    return super.fetchMoughataasFuture;
  }

  @override
  set fetchMoughataasFuture(ObservableFuture<MoughataaList?> value) {
    _$fetchMoughataasFutureAtom.reportWrite(value, super.fetchMoughataasFuture,
        () {
      super.fetchMoughataasFuture = value;
    });
  }

  late final _$fetchEntreprisesFutureAtom =
      Atom(name: '_ShopStore.fetchEntreprisesFuture', context: context);

  @override
  ObservableFuture<EntrepriseList?> get fetchEntreprisesFuture {
    _$fetchEntreprisesFutureAtom.reportRead();
    return super.fetchEntreprisesFuture;
  }

  @override
  set fetchEntreprisesFuture(ObservableFuture<EntrepriseList?> value) {
    _$fetchEntreprisesFutureAtom
        .reportWrite(value, super.fetchEntreprisesFuture, () {
      super.fetchEntreprisesFuture = value;
    });
  }

  late final _$fetchEntrepriseCodeFutureAtom =
      Atom(name: '_ShopStore.fetchEntrepriseCodeFuture', context: context);

  @override
  ObservableFuture<String> get fetchEntrepriseCodeFuture {
    _$fetchEntrepriseCodeFutureAtom.reportRead();
    return super.fetchEntrepriseCodeFuture;
  }

  @override
  set fetchEntrepriseCodeFuture(ObservableFuture<String> value) {
    _$fetchEntrepriseCodeFutureAtom
        .reportWrite(value, super.fetchEntrepriseCodeFuture, () {
      super.fetchEntrepriseCodeFuture = value;
    });
  }

  late final _$fetchMerchantsFutureAtom =
      Atom(name: '_ShopStore.fetchMerchantsFuture', context: context);

  @override
  ObservableFuture<MerchantList?> get fetchMerchantsFuture {
    _$fetchMerchantsFutureAtom.reportRead();
    return super.fetchMerchantsFuture;
  }

  @override
  set fetchMerchantsFuture(ObservableFuture<MerchantList?> value) {
    _$fetchMerchantsFutureAtom.reportWrite(value, super.fetchMerchantsFuture,
        () {
      super.fetchMerchantsFuture = value;
    });
  }

  late final _$addingEntrepriseFutureAtom =
      Atom(name: '_ShopStore.addingEntrepriseFuture', context: context);

  @override
  ObservableFuture<int?> get addingEntrepriseFuture {
    _$addingEntrepriseFutureAtom.reportRead();
    return super.addingEntrepriseFuture;
  }

  @override
  set addingEntrepriseFuture(ObservableFuture<int?> value) {
    _$addingEntrepriseFutureAtom
        .reportWrite(value, super.addingEntrepriseFuture, () {
      super.addingEntrepriseFuture = value;
    });
  }

  late final _$moughataaListAtom =
      Atom(name: '_ShopStore.moughataaList', context: context);

  @override
  MoughataaList? get moughataaList {
    _$moughataaListAtom.reportRead();
    return super.moughataaList;
  }

  @override
  set moughataaList(MoughataaList? value) {
    _$moughataaListAtom.reportWrite(value, super.moughataaList, () {
      super.moughataaList = value;
    });
  }

  late final _$entrepriseListAtom =
      Atom(name: '_ShopStore.entrepriseList', context: context);

  @override
  EntrepriseList? get entrepriseList {
    _$entrepriseListAtom.reportRead();
    return super.entrepriseList;
  }

  @override
  set entrepriseList(EntrepriseList? value) {
    _$entrepriseListAtom.reportWrite(value, super.entrepriseList, () {
      super.entrepriseList = value;
    });
  }

  late final _$entrepriseCodeAtom =
      Atom(name: '_ShopStore.entrepriseCode', context: context);

  @override
  String get entrepriseCode {
    _$entrepriseCodeAtom.reportRead();
    return super.entrepriseCode;
  }

  @override
  set entrepriseCode(String value) {
    _$entrepriseCodeAtom.reportWrite(value, super.entrepriseCode, () {
      super.entrepriseCode = value;
    });
  }

  late final _$merchantListAtom =
      Atom(name: '_ShopStore.merchantList', context: context);

  @override
  MerchantList? get merchantList {
    _$merchantListAtom.reportRead();
    return super.merchantList;
  }

  @override
  set merchantList(MerchantList? value) {
    _$merchantListAtom.reportWrite(value, super.merchantList, () {
      super.merchantList = value;
    });
  }

  late final _$successAtom = Atom(name: '_ShopStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$loadingMerchantAtom =
      Atom(name: '_ShopStore.loadingMerchant', context: context);

  @override
  bool get loadingMerchant {
    _$loadingMerchantAtom.reportRead();
    return super.loadingMerchant;
  }

  @override
  set loadingMerchant(bool value) {
    _$loadingMerchantAtom.reportWrite(value, super.loadingMerchant, () {
      super.loadingMerchant = value;
    });
  }

  late final _$addingMerchantAtom =
      Atom(name: '_ShopStore.addingMerchant', context: context);

  @override
  bool get addingMerchant {
    _$addingMerchantAtom.reportRead();
    return super.addingMerchant;
  }

  @override
  set addingMerchant(bool value) {
    _$addingMerchantAtom.reportWrite(value, super.addingMerchant, () {
      super.addingMerchant = value;
    });
  }

  late final _$addingEntrepriseAtom =
      Atom(name: '_ShopStore.addingEntreprise', context: context);

  @override
  bool get addingEntreprise {
    _$addingEntrepriseAtom.reportRead();
    return super.addingEntreprise;
  }

  @override
  set addingEntreprise(bool value) {
    _$addingEntrepriseAtom.reportWrite(value, super.addingEntreprise, () {
      super.addingEntreprise = value;
    });
  }

  late final _$getMoughataasAsyncAction =
      AsyncAction('_ShopStore.getMoughataas', context: context);

  @override
  Future<dynamic> getMoughataas() {
    return _$getMoughataasAsyncAction.run(() => super.getMoughataas());
  }

  late final _$addEntrepriseAsyncAction =
      AsyncAction('_ShopStore.addEntreprise', context: context);

  @override
  Future<dynamic> addEntreprise(Entreprise entreprise) {
    return _$addEntrepriseAsyncAction
        .run(() => super.addEntreprise(entreprise));
  }

  late final _$addMerchantAsyncAction =
      AsyncAction('_ShopStore.addMerchant', context: context);

  @override
  Future<dynamic> addMerchant(Merchant merchant) {
    return _$addMerchantAsyncAction.run(() => super.addMerchant(merchant));
  }

  late final _$getMerchantAsyncAction =
      AsyncAction('_ShopStore.getMerchant', context: context);

  @override
  Future<List<Merchant>?> getMerchant(String query) {
    return _$getMerchantAsyncAction.run(() => super.getMerchant(query));
  }

  late final _$getMyEntreprisesAsyncAction =
      AsyncAction('_ShopStore.getMyEntreprises', context: context);

  @override
  Future<dynamic> getMyEntreprises() {
    return _$getMyEntreprisesAsyncAction.run(() => super.getMyEntreprises());
  }

  late final _$getEntrepriseCodeAsyncAction =
      AsyncAction('_ShopStore.getEntrepriseCode', context: context);

  @override
  Future<dynamic> getEntrepriseCode(String moughataaCode) {
    return _$getEntrepriseCodeAsyncAction
        .run(() => super.getEntrepriseCode(moughataaCode));
  }

  @override
  String toString() {
    return '''
fetchMoughataasFuture: ${fetchMoughataasFuture},
fetchEntreprisesFuture: ${fetchEntreprisesFuture},
fetchEntrepriseCodeFuture: ${fetchEntrepriseCodeFuture},
fetchMerchantsFuture: ${fetchMerchantsFuture},
addingEntrepriseFuture: ${addingEntrepriseFuture},
moughataaList: ${moughataaList},
entrepriseList: ${entrepriseList},
entrepriseCode: ${entrepriseCode},
merchantList: ${merchantList},
success: ${success},
loadingMerchant: ${loadingMerchant},
addingMerchant: ${addingMerchant},
addingEntreprise: ${addingEntreprise},
loading: ${loading}
    ''';
  }
}
