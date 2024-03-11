class AddCategoryDto {
  final String name;
  final String? filePath;

  AddCategoryDto({
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
