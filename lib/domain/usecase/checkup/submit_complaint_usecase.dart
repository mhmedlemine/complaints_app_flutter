import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_complaint_dto.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class SubmitComplaintUsecase extends UseCase<Complaint, SubmitComplaintDto> {
  final CheckupRepository _checkupRepository;

  SubmitComplaintUsecase(this._checkupRepository);

  @override
  Future<Complaint> call({required params}) {
    return _checkupRepository.submitComplaint(params);
  }
}
