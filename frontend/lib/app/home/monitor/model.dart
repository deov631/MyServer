class HealthMonitorModel {
  final CpuInfo cpu;
  final MemoryInfo memory;
  final NetworkInfo network;

  HealthMonitorModel({
    required this.cpu,
    required this.memory,
    required this.network,
  });

  factory HealthMonitorModel.fromJson({
    Map<String, dynamic>? cpuJson,
    Map<String, dynamic>? memoryJson,
    Map<String, dynamic>? networkJson,
  }) {
    return HealthMonitorModel(
      cpu: CpuInfo.fromJson(cpuJson ?? {}),
      memory: MemoryInfo.fromJson(memoryJson ?? {}),
      network: NetworkInfo.fromJson(networkJson ?? {}),
    );
  }

  HealthMonitorModel copyWith({
    CpuInfo? cpu,
    MemoryInfo? memory,
    NetworkInfo? network,
  }) {
    return HealthMonitorModel(
      cpu: cpu ?? this.cpu,
      memory: memory ?? this.memory,
      network: network ?? this.network,
    );
  }
}

class CpuInfo {
  final double percent;

  CpuInfo({required this.percent});

  factory CpuInfo.fromJson(Map<String, dynamic> json) {
    return CpuInfo(
      percent: (json['percent'] as num?)?.toDouble() ?? 0.0,
    );
  }

  CpuInfo copyWith({double? percent}) {
    return CpuInfo(
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'percent': percent,
    };
  }
}

class MemoryInfo {
  final double percent;
  final double usedGb;
  final double totalGb;

  MemoryInfo({
    required this.percent,
    required this.usedGb,
    required this.totalGb,
  });

  factory MemoryInfo.fromJson(Map<String, dynamic> json) {
    return MemoryInfo(
      percent: (json['percent'] as num?)?.toDouble() ?? 0.0,
      usedGb: (json['used_gb'] as num?)?.toDouble() ?? 0.0,
      totalGb: (json['total_gb'] as num?)?.toDouble() ?? 0.0,
    );
  }

  MemoryInfo copyWith({
    double? percent,
    double? usedGb,
    double? totalGb,
  }) {
    return MemoryInfo(
      percent: percent ?? this.percent,
      usedGb: usedGb ?? this.usedGb,
      totalGb: totalGb ?? this.totalGb,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'percent': percent,
      'used_gb': usedGb,
      'total_gb': totalGb,
    };
  }
}

class NetworkInfo {
  final double uploadMbps;
  final double downloadMbps;

  NetworkInfo({
    required this.uploadMbps,
    required this.downloadMbps,
  });

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      uploadMbps: (json['upload_mbps'] as num?)?.toDouble() ?? 0.0,
      downloadMbps: (json['download_mbps'] as num?)?.toDouble() ?? 0.0,
    );
  }

  NetworkInfo copyWith({
    double? uploadMbps,
    double? downloadMbps,
  }) {
    return NetworkInfo(
      uploadMbps: uploadMbps ?? this.uploadMbps,
      downloadMbps: downloadMbps ?? this.downloadMbps,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'upload_mbps': uploadMbps,
      'download_mbps': downloadMbps,
    };
  }
}
