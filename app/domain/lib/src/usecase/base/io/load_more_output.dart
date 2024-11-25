import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../../domain.dart';

part 'load_more_output.freezed.dart';

@freezed
class LoadMoreOutput<T> extends BaseOutput with _$LoadMoreOutput<T> {
  const LoadMoreOutput._();

  const factory LoadMoreOutput({
    required List<T> data,
    @Default(null) Object? otherData,
    @Default(PagingConstants.initialPage) int page,
    @Default(false) bool isRefreshSuccess,
    @Default(0) int offset,
    @Default(false) bool isLastPage,
  }) = _LoadMoreOutput;

  int get nextPage => page + 1;
  int get previousPage => page - 1;
}
// \
// Future<void> loadMoreData() async {
//   final LoadMoreOutput<MyDataType> output = await fetchData();
  
//   if (output.isLastPage) {
//     // Không còn trang nào để tải thêm
//     return;
//   }

//   // Xử lý dữ liệu mới
//   final List<MyDataType> newData = output.data;
//   // Thêm newData vào danh sách hiện tại
// }