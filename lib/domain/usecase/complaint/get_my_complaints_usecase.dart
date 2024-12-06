
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/repository/complaint/complaint_repository.dart';

class GetMyComplaintsUseCase extends UseCase<ComplaintList, void> {

  final ComplaintRepository _complaintRepository;

  GetMyComplaintsUseCase(this._complaintRepository);

  @override
  Future<ComplaintList> call({required params}) {
    return _complaintRepository.getComplaints();
  }
}