import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';
part 'search_service_usecase.freezed.dart';

@Injectable()
class SearchServiceUseCase extends BaseLoadMoreUseCase<SearchServiceInput, ServiceItem> {
  SearchServiceUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<ServiceItem>> buildUseCase(SearchServiceInput input) {
    return _repository.searchService(
      page: page,
      limit: PagingConstants.itemsPerPage,
      query: input.query
    );
  }
}

@freezed
class SearchServiceInput extends BaseInput with _$SearchServiceInput {
  factory SearchServiceInput(
    {required String query}
  ) = _SearchServiceInput;
}
