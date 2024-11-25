import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'notification_item.freezed.dart';

@freezed
class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    @Default(NotificationItem.defaultNotificationId) String id,
    @Default(NotificationItem.defaultNotificationType) NotificationType notificationType,
    @Default(NotificationItem.defaultImage) String image,
    @Default(NotificationItem.defaultTitle) String title,
    @Default(NotificationItem.defaultMessage) String message,
  }) = _NotificationItem;

  static const defaultNotificationId = '';
  static const defaultNotificationType = NotificationType.defaultValue;
  static const defaultImage = '';
  static const defaultTitle = '';
  static const defaultMessage = '';
}
