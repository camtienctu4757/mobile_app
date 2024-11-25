import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'notify.dart';

@Injectable()
class NotificationBloc extends BaseBloc<NotifyEvent, NotifyState> {
  NotificationBloc() : super(NotifyState()) {
    on<NotifyLoading>((event, emit) => {});
    on<NotifyMarkasready>((event, emit) => {});
    on<NotifyDelete>(
      (event, emit) => {},
    );
  }
}
