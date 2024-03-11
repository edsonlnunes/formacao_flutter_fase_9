import 'package:my_library_app/features/contents/dtos/add_content.dto.dart';

class AddContentDTOBuilder {
  final int _categoryId = 1;
  final String _name = 'any_name';

  static AddContentDTOBuilder init() => AddContentDTOBuilder();

  AddContentDTO build() {
    return AddContentDTO(
      categoryId: _categoryId,
      name: _name,
    );
  }
}
