// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:shared/shared.dart';
// import '../../../domain.dart';

// part 'get_notify_use_case.freezed.dart';

// @Injectable()
// class GetNotifyUseCase
//     extends BaseFutureUseCase<GetNotifyInput, GetNotifyOutput> {
//   GetNotifyUseCase(this._repository) : super();
//   final Repository _repository;
//   @protected
//   @override
//   Future<GetNotifyOutput> buildUseCase(GetNotifyInput input) async {
//     final isLoggedIn = _repository.isLoggedIn;

//     if (isLoggedIn) {
//       final user = await _repository.getMe();
//       final user_id = user.id;
//       final notifications = await _repository.getNotifications(userId: user_id);
//       return GetNotifyOutput(
//           notifications: notifications,
//           totalNotifications: notifications.length);
//     }
//     return GetNotifyOutput(notifications: [], totalNotifications:0);
//   }
// }

// @freezed
// class GetNotifyInput extends BaseInput with _$GetNotifyInput {
//   const factory GetNotifyInput() = _GetNotifyInput;
// }

// @freezed
// class GetNotifyOutput extends BaseOutput with _$GetNotifyOutput {
//   const GetNotifyOutput._(); // Constructor cần có để sử dụng các phương thức tiện ích trong freezed
//   const factory GetNotifyOutput({
//     @Default([]) List<NotificationItem> notifications,
//     @Default(0) int totalNotifications,
//   }) = _GetNotifyOutput;
// }
