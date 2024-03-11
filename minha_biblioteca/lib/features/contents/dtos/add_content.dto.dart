class AddContentDto {
  final int categoryId;
  final String name;
  final bool isChecked;

  AddContentDto({
    required this.categoryId,
    required this.name,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isChecked': isChecked,
    };
  }
}
