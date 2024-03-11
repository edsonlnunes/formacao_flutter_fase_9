class UpdateContentDTO {
  final int categoryId;
  final int id;
  final bool isChecked;

  const UpdateContentDTO({
    required this.categoryId,
    required this.id,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() => {'isChecked': isChecked};
}
