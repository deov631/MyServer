import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/clip/provider.dart';
import 'package:frontend/widget/floating.dart';

class ClipboardPage extends StatefulWidget {
  const ClipboardPage({super.key});

  @override
  State<ClipboardPage> createState() => _ClipboardPageState();
}

class _ClipboardPageState extends State<ClipboardPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _handleUpload() async {
    final provider = context.read<ClipboardProvider>();
    final clipboardId = _titleController.text.trim();
    final content = _contentController.text;

    final success = await provider.uploadClipboard(clipboardId, content);
    if (success) {
      _showMessage('上传成功');
    } else if (provider.errorMessage != null) {
      _showMessage(provider.errorMessage!, isError: true);
    }
  }

  Future<void> _handleDownload() async {
    final provider = context.read<ClipboardProvider>();
    final clipboardId = _titleController.text.trim();

    await provider.getClipboard(clipboardId);

    if (provider.currentClipboard != null) {
      _contentController.text = provider.currentClipboard!.content;
      _showMessage('下载成功');
    } else if (provider.errorMessage != null) {
      _showMessage(provider.errorMessage!, isError: true);
    }
  }

  Future<void> _handleDelete() async {
    final provider = context.read<ClipboardProvider>();
    final clipboardId = _titleController.text.trim();

    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除剪切板 "$clipboardId" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await provider.deleteClipboard(clipboardId);
      if (success) {
        _titleController.clear();
        _contentController.clear();
        _showMessage('删除成功');
      } else if (provider.errorMessage != null) {
        _showMessage(provider.errorMessage!, isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClipboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: null,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 标题输入框和按钮行
                    FloatingCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                labelText: 'Clipboard ID',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 上传按钮
                          IconButton(
                            icon: const Icon(Icons.upload, color: Colors.white),
                            onPressed: provider.isLoading
                                ? null
                                : _handleUpload,
                            tooltip: '上传',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.blue,
                              disabledBackgroundColor: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // 下载按钮
                          IconButton(
                            icon: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            onPressed: provider.isLoading
                                ? null
                                : _handleDownload,
                            tooltip: '下载',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.green,
                              disabledBackgroundColor: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // 删除按钮
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: provider.isLoading
                                ? null
                                : _handleDelete,
                            tooltip: '删除',
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.red,
                              disabledBackgroundColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 文本输入区域
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: TextField(
                          controller: _contentController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Clipboard content here...',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 加载指示器
              if (provider.isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
