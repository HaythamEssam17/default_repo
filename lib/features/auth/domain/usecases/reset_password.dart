import '../../../../core/error/result.dart';
import '../repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository repository;

  const ResetPassword(this.repository);

  Future<Result<void>> call({
    required String token,
    required String newPassword,
  }) {
    return repository.resetPassword(token: token, newPassword: newPassword);
  }
}
