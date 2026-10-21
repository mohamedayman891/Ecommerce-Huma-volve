import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';

FailureApiResult<T> handleApiErrors<T>(dynamic e) {
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout ||
          DioExceptionType.connectionError:
        return FailureApiResult(NetworkError());

      case DioExceptionType.badResponse:
        final dynamic data = e.response?.data;
        if (data is Map) {
          String? extractedMessage;
          if (data['errors'] != null) {
            final errors = data['errors'];
            if (errors is Map) {
              extractedMessage =
                  errors['msg']?.toString() ?? errors['message']?.toString();
            } else if (errors is List && errors.isNotEmpty) {
              final first = errors.first;
              if (first is Map) {
                extractedMessage =
                    first['msg']?.toString() ?? first['message']?.toString();
              } else {
                extractedMessage = first.toString();
              }
            }
          }
          if (extractedMessage == null || extractedMessage.isEmpty) {
            final msg = data['message']?.toString();
            if (msg != null && msg.toLowerCase() != 'fail') {
              extractedMessage = msg;
            } else if (data['statusMsg'] != null &&
                data['statusMsg'].toString().toLowerCase() != 'fail') {
              extractedMessage = data['statusMsg'].toString();
            }
          }
          return FailureApiResult(ServerError(message: extractedMessage));
        }
        return FailureApiResult(ServerError());

      default:
        return FailureApiResult(ServerError());
    }
  } else {
    return FailureApiResult(ServerError());
  }
}
