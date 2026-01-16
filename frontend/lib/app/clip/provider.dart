import 'package:flutter/material.dart';
import 'service.dart';
import 'model.dart';

class ClipboardProvider with ChangeNotifier {
  final ClipboardService _service = ClipboardService();
  
  ClipboardModel? _currentClipboard;
  bool _isLoading = false;
  String? _errorMessage;

  ClipboardModel? get currentClipboard => _currentClipboard;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 获取剪贴板内容
  Future<void> getClipboard(String clipboardId) async {
    if (clipboardId.isEmpty) {
      _errorMessage = '请输入剪切板编号';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentClipboard = await _service.getClipboard(clipboardId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = '下载失败: $e';
      _currentClipboard = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 上传剪贴板内容
  Future<bool> uploadClipboard(String clipboardId, String content) async {
    if (clipboardId.isEmpty) {
      _errorMessage = '请输入剪切板编号';
      notifyListeners();
      return false;
    }

    if (content.isEmpty) {
      _errorMessage = '请输入内容';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _service.uploadClipboard(clipboardId, content);
      if (success) {
        _currentClipboard = ClipboardModel(id: clipboardId, content: content);
        _errorMessage = null;
      }
      return success;
    } catch (e) {
      _errorMessage = '上传失败: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 删除剪贴板内容
  Future<bool> deleteClipboard(String clipboardId) async {
    if (clipboardId.isEmpty) {
      _errorMessage = '请输入剪切板编号';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _service.deleteClipboard(clipboardId);
      if (success) {
        _currentClipboard = null;
        _errorMessage = null;
      }
      return success;
    } catch (e) {
      _errorMessage = '删除失败: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 清除错误消息
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
