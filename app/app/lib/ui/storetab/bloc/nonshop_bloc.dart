import 'nonshop.dart';
import 'package:injectable/injectable.dart';
import 'package:app/app.dart';

@Injectable()
class NonShopBloc extends BaseBloc<NonShopEvent, NonShopState> {
  NonShopBloc() : super(const NonShopState()) {}
}
