import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/config/api.dart';
import 'model.dart';

class HealthMonitorService {
  // 使用异步方法获取基础 URL
  static Future<String> getBaseUrl() async {
    final baseUrl = await ApiConfig.getBaseUrl();
    return 'http://$baseUrl/api/health';
  }
  
  // GET /cpu - 获取 CPU 信息
  Future<CpuInfo?> getCpuInfo() async {
    try {
      final url = await getBaseUrl();
      final response = await http.get(
        Uri.parse('$url/cpu'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CpuInfo.fromJson(data);
      } else {
        throw Exception('Failed to load CPU info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting CPU info: $e');
    }
  }

  // GET /memory - 获取内存信息
  Future<MemoryInfo?> getMemoryInfo() async {
    try {
      final url = await getBaseUrl();
      final response = await http.get(
        Uri.parse('$url/memory'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return MemoryInfo.fromJson(data);
      } else {
        throw Exception('Failed to load memory info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting memory info: $e');
    }
  }

  // GET /network - 获取网络信息
  Future<NetworkInfo?> getNetworkInfo() async {
    try {
      final url = await getBaseUrl();
      final response = await http.get(
        Uri.parse('$url/network'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NetworkInfo.fromJson(data);
      } else {
        throw Exception('Failed to load network info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting network info: $e');
    }
  }

  // 获取所有健康监控信息
  Future<HealthMonitorModel> getAllHealthInfo() async {
    final cpu = await getCpuInfo();
    final memory = await getMemoryInfo();
    final network = await getNetworkInfo();

    return HealthMonitorModel(
      cpu: cpu ?? CpuInfo(percent: 0.0),
      memory: memory ?? MemoryInfo(percent: 0.0, usedGb: 0.0, totalGb: 0.0),
      network: network ?? NetworkInfo(uploadMbps: 0.0, downloadMbps: 0.0),
    );
  }
}
