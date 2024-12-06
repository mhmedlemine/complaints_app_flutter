// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckupStore on _CheckupStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_CheckupStore.loading'))
      .value;

  late final _$fetchCheckupsFutureAtom =
      Atom(name: '_CheckupStore.fetchCheckupsFuture', context: context);

  @override
  ObservableFuture<CheckupList?> get fetchCheckupsFuture {
    _$fetchCheckupsFutureAtom.reportRead();
    return super.fetchCheckupsFuture;
  }

  @override
  set fetchCheckupsFuture(ObservableFuture<CheckupList?> value) {
    _$fetchCheckupsFutureAtom.reportWrite(value, super.fetchCheckupsFuture, () {
      super.fetchCheckupsFuture = value;
    });
  }

  late final _$fetchSummonsFutureAtom =
      Atom(name: '_CheckupStore.fetchSummonsFuture', context: context);

  @override
  ObservableFuture<SummonList?> get fetchSummonsFuture {
    _$fetchSummonsFutureAtom.reportRead();
    return super.fetchSummonsFuture;
  }

  @override
  set fetchSummonsFuture(ObservableFuture<SummonList?> value) {
    _$fetchSummonsFutureAtom.reportWrite(value, super.fetchSummonsFuture, () {
      super.fetchSummonsFuture = value;
    });
  }

  late final _$fetchInfractionsFutureAtom =
      Atom(name: '_CheckupStore.fetchInfractionsFuture', context: context);

  @override
  ObservableFuture<InfractionList?> get fetchInfractionsFuture {
    _$fetchInfractionsFutureAtom.reportRead();
    return super.fetchInfractionsFuture;
  }

  @override
  set fetchInfractionsFuture(ObservableFuture<InfractionList?> value) {
    _$fetchInfractionsFutureAtom
        .reportWrite(value, super.fetchInfractionsFuture, () {
      super.fetchInfractionsFuture = value;
    });
  }

  late final _$addingCheckupFutureAtom =
      Atom(name: '_CheckupStore.addingCheckupFuture', context: context);

  @override
  ObservableFuture<dynamic> get addingCheckupFuture {
    _$addingCheckupFutureAtom.reportRead();
    return super.addingCheckupFuture;
  }

  @override
  set addingCheckupFuture(ObservableFuture<dynamic> value) {
    _$addingCheckupFutureAtom.reportWrite(value, super.addingCheckupFuture, () {
      super.addingCheckupFuture = value;
    });
  }

  late final _$currentCheckupAtom =
      Atom(name: '_CheckupStore.currentCheckup', context: context);

  @override
  Checkup? get currentCheckup {
    _$currentCheckupAtom.reportRead();
    return super.currentCheckup;
  }

  @override
  set currentCheckup(Checkup? value) {
    _$currentCheckupAtom.reportWrite(value, super.currentCheckup, () {
      super.currentCheckup = value;
    });
  }

  late final _$entrepriseAtom =
      Atom(name: '_CheckupStore.entreprise', context: context);

  @override
  Entreprise? get entreprise {
    _$entrepriseAtom.reportRead();
    return super.entreprise;
  }

  @override
  set entreprise(Entreprise? value) {
    _$entrepriseAtom.reportWrite(value, super.entreprise, () {
      super.entreprise = value;
    });
  }

  late final _$infractionsListAtom =
      Atom(name: '_CheckupStore.infractionsList', context: context);

  @override
  InfractionList? get infractionsList {
    _$infractionsListAtom.reportRead();
    return super.infractionsList;
  }

  @override
  set infractionsList(InfractionList? value) {
    _$infractionsListAtom.reportWrite(value, super.infractionsList, () {
      super.infractionsList = value;
    });
  }

  late final _$checkupListAtom =
      Atom(name: '_CheckupStore.checkupList', context: context);

  @override
  CheckupList? get checkupList {
    _$checkupListAtom.reportRead();
    return super.checkupList;
  }

  @override
  set checkupList(CheckupList? value) {
    _$checkupListAtom.reportWrite(value, super.checkupList, () {
      super.checkupList = value;
    });
  }

  late final _$summonListAtom =
      Atom(name: '_CheckupStore.summonList', context: context);

  @override
  SummonList? get summonList {
    _$summonListAtom.reportRead();
    return super.summonList;
  }

  @override
  set summonList(SummonList? value) {
    _$summonListAtom.reportWrite(value, super.summonList, () {
      super.summonList = value;
    });
  }

  late final _$complaintCheckupListAtom =
      Atom(name: '_CheckupStore.complaintCheckupList', context: context);

  @override
  CheckupList? get complaintCheckupList {
    _$complaintCheckupListAtom.reportRead();
    return super.complaintCheckupList;
  }

  @override
  set complaintCheckupList(CheckupList? value) {
    _$complaintCheckupListAtom.reportWrite(value, super.complaintCheckupList,
        () {
      super.complaintCheckupList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_CheckupStore.success', context: context);

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

  late final _$addingCheckupAtom =
      Atom(name: '_CheckupStore.addingCheckup', context: context);

  @override
  bool get addingCheckup {
    _$addingCheckupAtom.reportRead();
    return super.addingCheckup;
  }

  @override
  set addingCheckup(bool value) {
    _$addingCheckupAtom.reportWrite(value, super.addingCheckup, () {
      super.addingCheckup = value;
    });
  }

  late final _$loadingEntrepriseAtom =
      Atom(name: '_CheckupStore.loadingEntreprise', context: context);

  @override
  bool get loadingEntreprise {
    _$loadingEntrepriseAtom.reportRead();
    return super.loadingEntreprise;
  }

  @override
  set loadingEntreprise(bool value) {
    _$loadingEntrepriseAtom.reportWrite(value, super.loadingEntreprise, () {
      super.loadingEntreprise = value;
    });
  }

  late final _$loadingComplaintsAtom =
      Atom(name: '_CheckupStore.loadingComplaints', context: context);

  @override
  bool get loadingComplaints {
    _$loadingComplaintsAtom.reportRead();
    return super.loadingComplaints;
  }

  @override
  set loadingComplaints(bool value) {
    _$loadingComplaintsAtom.reportWrite(value, super.loadingComplaints, () {
      super.loadingComplaints = value;
    });
  }

  late final _$loadingConsumerAtom =
      Atom(name: '_CheckupStore.loadingConsumer', context: context);

  @override
  bool get loadingConsumer {
    _$loadingConsumerAtom.reportRead();
    return super.loadingConsumer;
  }

  @override
  set loadingConsumer(bool value) {
    _$loadingConsumerAtom.reportWrite(value, super.loadingConsumer, () {
      super.loadingConsumer = value;
    });
  }

  late final _$getInfractionsAsyncAction =
      AsyncAction('_CheckupStore.getInfractions', context: context);

  @override
  Future<dynamic> getInfractions() {
    return _$getInfractionsAsyncAction.run(() => super.getInfractions());
  }

  late final _$startCheckupAsyncAction =
      AsyncAction('_CheckupStore.startCheckup', context: context);

  @override
  Future<void> startCheckup(
      {required String type, required double lat, required double lon}) {
    return _$startCheckupAsyncAction
        .run(() => super.startCheckup(type: type, lat: lat, lon: lon));
  }

  late final _$saveCheckupProgressAsyncAction =
      AsyncAction('_CheckupStore.saveCheckupProgress', context: context);

  @override
  Future<void> saveCheckupProgress(
      {required int checkupId,
      String? notes,
      required List<Map<String, dynamic>> infractions,
      required List<Map<String, dynamic>> custom_infractions,
      required List<String> deleted_evidence_files}) {
    return _$saveCheckupProgressAsyncAction.run(() => super.saveCheckupProgress(
        checkupId: checkupId,
        notes: notes,
        infractions: infractions,
        custom_infractions: custom_infractions,
        deleted_evidence_files: deleted_evidence_files));
  }

  late final _$submitCheckupAsyncAction =
      AsyncAction('_CheckupStore.submitCheckup', context: context);

  @override
  Future<void> submitCheckup(
      {required int checkupId,
      String? notes,
      required List<Map<String, dynamic>> infractions,
      required List<Map<String, dynamic>> custom_infractions,
      required List<String> deleted_evidence_files,
      DateTime? duedate,
      required String action_taken}) {
    return _$submitCheckupAsyncAction.run(() => super.submitCheckup(
        checkupId: checkupId,
        notes: notes,
        infractions: infractions,
        custom_infractions: custom_infractions,
        deleted_evidence_files: deleted_evidence_files,
        duedate: duedate,
        action_taken: action_taken));
  }

  late final _$cancelCheckupAsyncAction =
      AsyncAction('_CheckupStore.cancelCheckup', context: context);

  @override
  Future<void> cancelCheckup({required int checkupId}) {
    return _$cancelCheckupAsyncAction
        .run(() => super.cancelCheckup(checkupId: checkupId));
  }

  late final _$addCheckupAsyncAction =
      AsyncAction('_CheckupStore.addCheckup', context: context);

  @override
  Future<dynamic> addCheckup(AddCheckupParams params) {
    return _$addCheckupAsyncAction.run(() => super.addCheckup(params));
  }

  late final _$getEntrepriseAsyncAction =
      AsyncAction('_CheckupStore.getEntreprise', context: context);

  @override
  Future<Entreprise?> getEntreprise(double lat, double lon) {
    return _$getEntrepriseAsyncAction.run(() => super.getEntreprise(lat, lon));
  }

  late final _$getMyCheckupsAsyncAction =
      AsyncAction('_CheckupStore.getMyCheckups', context: context);

  @override
  Future<dynamic> getMyCheckups() {
    return _$getMyCheckupsAsyncAction.run(() => super.getMyCheckups());
  }

  late final _$getMySummonsAsyncAction =
      AsyncAction('_CheckupStore.getMySummons', context: context);

  @override
  Future<dynamic> getMySummons() {
    return _$getMySummonsAsyncAction.run(() => super.getMySummons());
  }

  late final _$getMyComplaintCheckupsAsyncAction =
      AsyncAction('_CheckupStore.getMyComplaintCheckups', context: context);

  @override
  Future<dynamic> getMyComplaintCheckups() {
    return _$getMyComplaintCheckupsAsyncAction
        .run(() => super.getMyComplaintCheckups());
  }

  late final _$submitComplaintAsyncAction =
      AsyncAction('_CheckupStore.submitComplaint', context: context);

  @override
  Future<void> submitComplaint(
      {required String title,
      required String description,
      required String greenNumber,
      required int consumerId,
      required String shopAddress,
      required Map<int, bool> selectedInfractions,
      required Map<int, String> infractionNotes,
      required List<Map<String, dynamic>> customInfractions}) {
    return _$submitComplaintAsyncAction.run(() => super.submitComplaint(
        title: title,
        description: description,
        greenNumber: greenNumber,
        consumerId: consumerId,
        shopAddress: shopAddress,
        selectedInfractions: selectedInfractions,
        infractionNotes: infractionNotes,
        customInfractions: customInfractions));
  }

  late final _$addConsumerAsyncAction =
      AsyncAction('_CheckupStore.addConsumer', context: context);

  @override
  Future<Consumer> addConsumer(Consumer consumer) {
    return _$addConsumerAsyncAction.run(() => super.addConsumer(consumer));
  }

  late final _$searchConsumersAsyncAction =
      AsyncAction('_CheckupStore.searchConsumers', context: context);

  @override
  Future<ConsumerList> searchConsumers(String query) {
    return _$searchConsumersAsyncAction.run(() => super.searchConsumers(query));
  }

  @override
  String toString() {
    return '''
fetchCheckupsFuture: ${fetchCheckupsFuture},
fetchSummonsFuture: ${fetchSummonsFuture},
fetchInfractionsFuture: ${fetchInfractionsFuture},
addingCheckupFuture: ${addingCheckupFuture},
currentCheckup: ${currentCheckup},
entreprise: ${entreprise},
infractionsList: ${infractionsList},
checkupList: ${checkupList},
summonList: ${summonList},
complaintCheckupList: ${complaintCheckupList},
success: ${success},
addingCheckup: ${addingCheckup},
loadingEntreprise: ${loadingEntreprise},
loadingComplaints: ${loadingComplaints},
loadingConsumer: ${loadingConsumer},
loading: ${loading}
    ''';
  }
}
