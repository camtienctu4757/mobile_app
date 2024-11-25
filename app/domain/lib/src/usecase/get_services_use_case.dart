import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_services_use_case.freezed.dart';

@Injectable()
class GetServicesUseCase extends BaseLoadMoreUseCase<GetServiceInput, ServiceItem> {
  GetServicesUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<ServiceItem>> buildUseCase(GetServiceInput input) {
    return _repository.getServices(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetServiceInput extends BaseInput with _$GetServiceInput {
  const factory GetServiceInput() = _GetServiceInput;
}
