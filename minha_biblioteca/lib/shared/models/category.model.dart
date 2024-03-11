class Category {
  final int id;
  final String name;
  final String? filePath;

  Category({
    required this.id,
    required this.name,
    this.filePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'filePath': filePath,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      filePath: map['filePath'] != null ? map['filePath'] as String : null,
    );
  }
}
