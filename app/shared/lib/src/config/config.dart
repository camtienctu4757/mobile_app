import 'package:async/async.dart';

abstract class Config {
  //  một phương thức bất đồng bộ (asynchronous method) chỉ được thực thi một lần.
  final AsyncMemoizer<void> _asyncMemoizer = AsyncMemoizer<void>();
  Future<void> config();
  Future<void> init() => _asyncMemoizer.runOnce(config);
}
