class Photo {
  final String fileUuid;
  final String folderPath;
  final String fileName;
  Photo({
    required this.fileUuid,
    required this.folderPath,
    required this.fileName,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      fileUuid: json['file_uuid'] as String,
      folderPath: json['folder_path'] as String,
      fileName: json['file_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_uuid': fileUuid,
      'folder_path': folderPath,
      'file_name': fileName,
    };
  }
}
