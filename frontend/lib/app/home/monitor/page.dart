import 'package:flutter/material.dart';
import 'package:frontend/widget/floating.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
import 'model.dart';

class HomeMonitorPage extends StatefulWidget {
  const HomeMonitorPage({super.key});

  @override
  State<HomeMonitorPage> createState() => _HomeMonitorPageState();
}

class _HomeMonitorPageState extends State<HomeMonitorPage> {
  @override
  void initState() {
    super.initState();
    // 页面加载时启动自动刷新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HealthMonitorProvider>(context, listen: false);
      provider.startAutoRefresh();
    });
  }

  @override
  void dispose() {
    // 页面销毁时停止自动刷新
    final provider = Provider.of<HealthMonitorProvider>(context, listen: false);
    provider.stopAutoRefresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Consumer<HealthMonitorProvider>(
                    builder: (context, provider, child) {
                      final cpuData = provider.healthData?.cpu ?? CpuInfo(percent: 0.0);
                      return _buildCpuCard(cpuData);
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<HealthMonitorProvider>(
                    builder: (context, provider, child) {
                      final memoryData = provider.healthData?.memory ?? MemoryInfo(percent: 0.0, usedGb: 0.0, totalGb: 0.0);
                      return _buildMemoryCard(memoryData);
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<HealthMonitorProvider>(
                    builder: (context, provider, child) {
                      final networkData = provider.healthData?.network ?? NetworkInfo(uploadMbps: 0.0, downloadMbps: 0.0);
                      return _buildNetworkCard(networkData);
                    },
                  ),
                ),
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }

  Widget _buildCpuCard(CpuInfo cpuData) {
    return MyFloatingCard(
      title: "CPU",
      color1: Colors.orangeAccent,
      color2: Colors.orange,
      height: 240,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${cpuData.percent.toStringAsFixed(1)}%",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryCard(MemoryInfo memoryData) {
    return MyFloatingCard(
      title: "Memory",
      color1: Colors.lightBlue,
      color2: Colors.blue,
      height: 240,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${memoryData.percent.toStringAsFixed(1)}%",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${memoryData.usedGb.toStringAsFixed(2)} GB / ${memoryData.totalGb.toStringAsFixed(2)} GB",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkCard(NetworkInfo networkData) {
    return MyFloatingCard(
      title: "Network",
      color1: Colors.lightGreen,
      color2: Colors.green,
      height: 240,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "↑ ${networkData.uploadMbps.toStringAsFixed(2)} MB/s",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "↓ ${networkData.downloadMbps.toStringAsFixed(2)} MB/s",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}