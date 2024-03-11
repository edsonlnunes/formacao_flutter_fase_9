// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddContentDTO {
  final int categoryId;
  final String name;

  const AddContentDTO({
    required this.categoryId,
    required this.name,
  });

  Map<String, dynamic> toMap() => {'name': name};

  @override
  String toString() => 'AddContentDTO(categoryId: $categoryId, name: $name)';
}
