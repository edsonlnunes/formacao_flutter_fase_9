class AddCategoryDTO {
  final String name;
  final String? filePath;

  const AddCategoryDTO({
    required this.name,
    this.filePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'filePath': filePath,
    };
  }
}
