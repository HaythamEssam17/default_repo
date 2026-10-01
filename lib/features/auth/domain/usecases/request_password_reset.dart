import '../../../../core/error/result.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordReset {
  final AuthRepository repository;

  const RequestPasswordReset(this.repository);

  Future<Result<void>> call({required String email}) {
    return repository.requestPasswordReset(email: email);
  }
}
