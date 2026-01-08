class ApiConfig {
  // 后端 API 基础地址
  // 开发环境：使用 localhost
  // 生产环境：替换为实际的服务器地址
  static const String baseUrl = 'http://localhost:8000';
  
  // 如果需要根据环境自动切换，可以使用：
  // static const String baseUrl = 
  //     const String.fromEnvironment('API_URL', defaultValue: 'http://localhost:8000');
}
