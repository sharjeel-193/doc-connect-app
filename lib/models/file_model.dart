class FileModel {
  String filePath;
  String title;

  FileModel({
    required this.filePath,
    required this.title,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      filePath: json['filePath'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filePath': filePath,
      'title': title,
    };
  }
}
