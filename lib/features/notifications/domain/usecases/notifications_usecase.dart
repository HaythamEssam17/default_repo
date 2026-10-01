import '../repositories/notifications_repository.dart';

class NotificationsUseCase {
  final NotificationsRepository repository;

  NotificationsUseCase(this.repository);

  Future<void> doSomething() async {
    return repository.doSomething();
  }
}
