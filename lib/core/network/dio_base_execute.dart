import 'package:dartz/dartz.dart';

import '../model/base_model.dart';
import 'error_handling/custom_error.dart';
import 'error_handling/custom_exception.dart';

Future<Either<CustomError, BaseModel>> executeAndHandleError(
  Future<BaseModel> Function() function,
) async {
  try {
    final BaseModel result = await function();
    return right(BaseModel.fromJson(result.data));
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
