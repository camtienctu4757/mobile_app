import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';

@Injectable()
class ApiUserDataMapper extends BaseDataMapper<ApiUserData, User> {
  ApiUserDataMapper(
    // this._genderDataMapper,
    // this._apiImageUrlDataMapper,
  );

  @override
  User mapToEntity(ApiUserData? data) {
    return User(
      id: data?.id ?? User.defaultId,
      email: data?.email ?? User.defaultEmail,
      name: data?.name ?? User.defaultName,
      phone: data?.phone ?? User.defaultPhone,
      // money: BigDecimal.tryParse(data?.money) ?? User.defaultMoney,
      // birthday: DateTimeUtils.tryParse(
      //       date: data?.birthday,
      //       format: DateTimeFormatConstants.appServerResponse,
      //     ) ??
      //     User.defaultBirthday,
      // avatar: _apiImageUrlDataMapper.mapToEntity(data?.avatar),
      // photos: _apiImageUrlDataMapper.mapToListEntity(data?.photos),
      // gender: _genderDataMapper.mapToEntity(data?.gender),
    );
  }
}
