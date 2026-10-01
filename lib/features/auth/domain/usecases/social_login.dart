import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class SocialLogin {
  final AuthRepository repository;

  const SocialLogin(this.repository);

  Future<Result<AuthSession>> call({
    required String provider,
    required String accessToken,
  }) {
    return repository.socialLogin(provider: provider, accessToken: accessToken);
  }
}
