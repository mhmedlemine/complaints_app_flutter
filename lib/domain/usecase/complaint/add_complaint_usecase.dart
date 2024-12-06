import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/repository/complaint/complaint_repository.dart';

class InsertPostUseCase extends UseCase<int, Complaint> {
  final ComplaintRepository _complaintRepository;

  InsertPostUseCase(this._complaintRepository);

  @override
  Future<int> call({required params}) {
    return _complaintRepository.insert(params);
  }
}
