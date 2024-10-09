import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/post/post.dart';
import 'package:complaintsapp/domain/repository/post/post_repository.dart';

class FindPostByIdUseCase extends UseCase<List<Post>, int> {
  final PostRepository _postRepository;

  FindPostByIdUseCase(this._postRepository);

  @override
  Future<List<Post>> call({required int params}) {
    return _postRepository.findPostById(params);
  }
}
