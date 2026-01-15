import 'dart:async';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;

class ApiConfig {
  static const String _globalUrl = "101.200.150.178:12000";
  static const String _localUrl = "localhost:8000";

  static String? _cachedBaseUrl;

  static Future<String> getBaseUrl() async {
    if (_cachedBaseUrl != null) {
      return _cachedBaseUrl!;
    }

    // 尝试连接本地服务器健康检查
    try {
      final response = await http.get(Uri.parse('http://$_localUrl/api/health/ping')).timeout(
            const Duration(seconds: 1),
          );
      
      if (response.statusCode == 200) {
        // 本地服务器健康检查成功，使用本地URL
        _cachedBaseUrl = _localUrl;
        debugPrint("Using local URL: $_localUrl");
      } else {
        // 本地服务器健康检查失败，使用回退URL
        _cachedBaseUrl = _globalUrl;
        debugPrint("Using global URL: $_globalUrl");
      }
    } catch (e) {
      // 本地服务器连接失败，使用回退URL
      _cachedBaseUrl = _globalUrl;
      debugPrint("Using global URL: $_globalUrl");
    }

    return _cachedBaseUrl!;
  }
}