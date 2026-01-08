import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/clip/model.dart';
import 'package:frontend/config/api.dart';

class ClipboardService {
  static String get baseUrl => ApiConfig.baseUrl;
  
  // GET /{clipboard_id} - 获取剪贴板内容
  Future<ClipboardModel?> getClipboard(String clipboardId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/clip/$clipboardId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ClipboardModel.fromJson(data);
      } else {
        throw Exception('Failed to load clipboard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting clipboard: $e');
    }
  }

  // POST /{clipboard_id} - 上传/更新剪贴板内容
  Future<bool> uploadClipboard(String clipboardId, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/clip/$clipboardId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': clipboardId,
          'content': content
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to upload clipboard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading clipboard: $e');
    }
  }

  // DELETE /{clipboard_id} - 删除剪贴板内容
  Future<bool> deleteClipboard(String clipboardId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/clip/$clipboardId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete clipboard: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting clipboard: $e');
    }
  }
}
