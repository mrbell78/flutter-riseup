import 'package:get_it/get_it.dart';
import 'package:masterstudy_app/api_rubel_portion/api-service/apiservice.dart';
import 'package:masterstudy_app/api_rubel_portion/http_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async{

  locator.registerLazySingleton<HttpService>(() => HttpService());
  locator.registerLazySingleton<ApiService>(() => ApiService());


}