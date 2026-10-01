import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  const Register(this.repository);

  Future<Result<AuthSession>> call({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) {
    return repository.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
