import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
part 'user_update_booking_cancle_usecase.freezed.dart';

@Injectable()
class UserUpdateBookingCancleUseCase
    extends BaseFutureUseCase<UserUpdateBookingCancleInput,UserUpdateBookingCancleOutput> {
  const UserUpdateBookingCancleUseCase(
    this._repository,
  );

  final Repository _repository;

  @protected
  @override
  Future<UserUpdateBookingCancleOutput> buildUseCase(UserUpdateBookingCancleInput input) async {
    final response = await _repository.userUpdateCancle(id: input.id);
    return UserUpdateBookingCancleOutput(isSuccess: response);
  }
}

@freezed
class UserUpdateBookingCancleInput extends BaseInput with _$UserUpdateBookingCancleInput {
  const factory UserUpdateBookingCancleInput(
      {required String id}) = _UserUpdateBookingCancleInput;
}

@freezed
class UserUpdateBookingCancleOutput extends BaseOutput with _$UserUpdateBookingCancleOutput {
  const UserUpdateBookingCancleOutput._();

  const factory UserUpdateBookingCancleOutput({required bool isSuccess}) = _UserUpdateBookingCancleOutput;
}
