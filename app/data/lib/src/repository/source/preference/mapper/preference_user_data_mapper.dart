import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data.dart';

@Injectable()
class PreferenceUserDataMapper extends BaseDataMapper<PreferenceUserData, User>
    with DataMapperMixin {
  @override
  User mapToEntity(PreferenceUserData? data) {
    return User(
      id: data?.id ?? User.defaultId,
      name: data?.name ?? User.defaultName,
      email: data?.email ?? User.defaultEmail,
    );
  }

  @override
  PreferenceUserData mapToData(User entity) {
    return PreferenceUserData(
      id: entity.id,
      name: entity.name,
      email: entity.email,
    );
  }
}
