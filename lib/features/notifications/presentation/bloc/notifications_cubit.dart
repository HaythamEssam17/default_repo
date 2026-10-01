import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_states.dart';
import '../../domain/usecases/notifications_usecase.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsUseCase useCase;

  NotificationsCubit(this.useCase) : super(NotificationsInitial());
}
