class UpdateContentDto {
  final int categoryId;
  final int contentId;
  final bool isChecked;

  UpdateContentDto({
    required this.categoryId,
    required this.contentId,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isChecked': isChecked,
    };
  }
}
