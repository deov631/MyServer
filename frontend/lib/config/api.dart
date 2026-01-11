import 'package:frontend/config/env.dart';

class ApiConfig {

  // API 地址
  static const String debugBaseUrl = 'http://localhost:12000';
  static const String releaseBaseUrl = 'http://101.200.150.178:12000';
  static const String baseUrl = Env.isDebug ? debugBaseUrl : releaseBaseUrl;
}
