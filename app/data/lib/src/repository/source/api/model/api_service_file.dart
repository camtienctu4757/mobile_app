import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_service_file.freezed.dart';
part 'api_service_file.g.dart';
@freezed
class ApiServiceFile with _$ApiServiceFile {
  const ApiServiceFile._();

  const factory ApiServiceFile({
    @JsonKey(name: 'file_uuid') String? id,
    @JsonKey(name: 'folder_path') String? path,
    @JsonKey(name: 'file_name') String? file_name, 
  }) = _ApiServiceFile;
  factory ApiServiceFile.fromJson(Map<String, dynamic> json) => _$ApiServiceFileFromJson(json);

}