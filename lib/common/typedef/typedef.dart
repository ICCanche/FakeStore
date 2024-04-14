import 'package:dartz/dartz.dart';
import 'package:fake_store/common/error/failure.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;