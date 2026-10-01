import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class RestoreSession {
  final AuthRepository repository;

  const RestoreSession(this.repository);

  Future<Result<AuthSession>> call() {
    return repository.restoreSession();
  }
}
