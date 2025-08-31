import 'package:dartz/dartz.dart';

import 'error_handling/custom_error.dart';
import 'error_handling/custom_exception.dart';

Future<Either<CustomError, T>> executeAndHandleError<T>(
  Future<T> Function() function,
) async {
  try {
    final T result = await function();
    return Right(result);
  } on CustomException catch (ex) {
    return Left(
      CustomError(
        type: ex.type,
        errorMassage: ex.errorMassage,
        imgPath: ex.imgPath,
      ),
    );
  }
}
