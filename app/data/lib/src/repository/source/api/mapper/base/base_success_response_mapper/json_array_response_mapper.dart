// import 'dart:js_interop';

import 'package:shared/shared.dart';

import '../../../../../../../data.dart';

class JsonArrayResponseMapper<T extends Object>
    extends BaseSuccessResponseMapper<T, List<T>> {
  @override
  // ignore: avoid-dynamic
  List<T>? mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    // print(decoder != null && response is List);
    // print(response.toString());
    return decoder != null && response is List
        ? response
            .map((jsonObject) => decoder(jsonObject as Map<String, dynamic>))
            .toList(growable: false)
        : null;
  }
}
