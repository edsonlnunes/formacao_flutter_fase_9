// ignore_for_file: public_member_api_docs, sort_constructors_first
class Content {
  final int id;
  final String name;
  final bool isChecked;

  Content({
    required this.id,
    required this.name,
    this.isChecked = false,
  });

  Content copyWith({
    int? id,
    String? name,
    bool? isChecked,
  }) {
    return Content(
      id: id ?? this.id,
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isChecked': isChecked,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      id: map['id'] as int,
      name: map['name'] as String,
      isChecked: map['isChecked'] as bool,
    );
  }

  @override
  bool operator ==(covariant Content other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.isChecked == isChecked;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isChecked.hashCode;
}
