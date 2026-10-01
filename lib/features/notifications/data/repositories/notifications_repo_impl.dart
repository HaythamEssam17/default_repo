import '../../domain/repositories/notifications_repository.dart';
import '../ds/remote/notifications_remote_ds.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remote;

  NotificationsRepositoryImpl(this.remote);

  @override
  Future<void> doSomething() async {
    await remote.fetchData();
  }
}
