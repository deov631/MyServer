import 'dart:async';
import 'package:flutter/material.dart';
import 'service.dart';
import 'model.dart';

class HealthMonitorProvider with ChangeNotifier {
  final HealthMonitorService _service = HealthMonitorService();
  
  HealthMonitorModel? _healthData;
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _refreshTimer;

  HealthMonitorModel? get healthData => _healthData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 开始自动刷新（每秒刷新一次）
  void startAutoRefresh() {
    // 立即获取一次数据
    _loadHealthData();
    
    // 设置定时器，每秒刷新一次
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _loadHealthData();
    });
  }

  // 停止自动刷新
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  // 加载健康数据
  Future<void> _loadHealthData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _healthData = await _service.getAllHealthInfo();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = '加载失败：$e';
      // 保持之前的数据，不设置为 null
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 手动刷新
  Future<void> refresh() async {
    await _loadHealthData();
  }

  // 清除错误消息
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
}
