import 'package:fake_store/common/error/api_exception.dart';
import 'package:fake_store/common/error/failure.dart';

class ApiFailure extends Failure {
  const ApiFailure(super.message, super.statusCode);

  ApiFailure.fromException(ApiException exception)
      : super(
          exception.message,
          exception.statusCode,
        );
}
