import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_event.dart';

part 'notify_event.freezed.dart';

abstract class NotifyEvent extends BaseBlocEvent {
  const NotifyEvent();
}

@freezed
class NotifyLoading extends NotifyEvent with _$NotifyLoading {
  const factory NotifyLoading() = _NotifyLoading;
}

@freezed
class NotifyMarkasready extends NotifyEvent with _$NotifyMarkasready {
  const factory NotifyMarkasready() = _NotifyMarkasready;
}

@freezed
class NotifyDelete extends NotifyEvent with _$NotifyDelete {
const factory NotifyDelete() = _NotifyDelete;
  
}
