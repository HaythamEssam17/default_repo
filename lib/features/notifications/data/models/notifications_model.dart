import '../../domain/entities/notifications_entity.dart';

class NotificationsModel extends NotificationsEntity {
  const NotificationsModel();

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel();
  }

  Map<String, dynamic> toJson() => {};
}
