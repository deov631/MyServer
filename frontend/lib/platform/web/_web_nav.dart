// Web 平台的跳转实现
import 'package:web/web.dart' as web;

void openInNewTab(String path) {
  final url = '${web.window.location.origin}/#$path';
  web.window.open(url, '_blank');
}
