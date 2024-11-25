import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';
import 'package:shared/shared.dart';
import 'package:domain/domain.dart';
part 'notify_state.freezed.dart';

@freezed
class NotifyState extends BaseBlocState with _$NotifyState {
  factory NotifyState({
    @Default(LoadMoreOutput<NotificationItem> (data: <NotificationItem>[]))
    LoadMoreOutput<NotificationItem>
    notifications, // Danh sách thông báo
     @Default(false) bool isShimmerLoading,// Trạng thái tải dữ liệu
     AppException? loadNotifyException, // Trạng thái lỗi khi tải thông báo
    @Default(false) bool isDeleting, // Trạng thái xóa thông báo
  }) = _NotifyState;
}
