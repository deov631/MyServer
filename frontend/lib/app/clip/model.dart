class ClipboardModel {
  final String id;
  final String content;

  ClipboardModel({
    required this.id,
    required this.content,
  });

  factory ClipboardModel.fromJson(Map<String, dynamic> json) {
    return ClipboardModel(
      id: json['id'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
    };
  }

  ClipboardModel copyWith({
    String? id,
    String? content,
  }) {
    return ClipboardModel(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }
}
