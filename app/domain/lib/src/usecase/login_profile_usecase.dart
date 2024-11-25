// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';

// import '../../domain.dart';

// part 'login_profile_usecase.freezed.dart';

// @Injectable()
// class IsLoggedInProfileUseCase extends BaseSyncUseCase<IsLoggedInInput, IsLoggedInOutput> {
//   const IsLoggedInProfileUseCase(this._repository, this._navigator);

//   final Repository _repository;
//    final AppNavigator _navigator;
//   @protected
//   @override
//   Future<IsLoggedInOutput> buildUseCase(IsLoggedInInput input) async {
//     // return IsLoggedInOutput(isLoggedIn: _repository.isLoggedIn);
//     if(_repository.isLoggedIn){
//       await _navigator.replace(const AppRouteInfo.profile(input.user));
//     }
//   }
// }

// @freezed
// class IsLoggedInInput extends BaseInput with _$IsLoggedInInput {
//   const factory IsLoggedInInput({
//     required User user
//   }) = _IsLoggedInInput;
// }

// @freezed
// class IsLoggedInOutput extends BaseOutput with _$IsLoggedInOutput {
//   const IsLoggedInOutput._();

//   const factory IsLoggedInOutput({
//     @Default(false) bool isLoggedIn,
//   }) = _IsLoggedInOutput;
// }
