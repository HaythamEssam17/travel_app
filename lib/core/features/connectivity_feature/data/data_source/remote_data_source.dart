import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../app/di/injection.dart';
import '../../../../network/dio_client.dart';

abstract class ConnectivityRemoteDataSourceInterface {
  Future<bool> checkConnection();
}

class ConnectivityRemoteDataSourceImp
    extends ConnectivityRemoteDataSourceInterface {
  @override
  Future<bool> checkConnection() async {
    try {
      final dioHelper = getIt<DioHelper>();
      final String url = dotenv.get('base_url');

      final Response response = await dioHelper.dio.get(url);
      if (response.statusCode == 200) {
        return Future(() => true);
      } else {
        return Future(() => false);
      }
    } catch (e) {
      return Future(() => false);
    }
  }
}
