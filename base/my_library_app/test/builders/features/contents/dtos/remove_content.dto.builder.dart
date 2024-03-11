import 'package:my_library_app/features/contents/dtos/remove_content.dto.dart';

class RemoveContentDTOBuilder {
  final int _categoryId = 1;
  final int _id = 1;

  static RemoveContentDTOBuilder init() => RemoveContentDTOBuilder();

  RemoveContentDTO build() {
    return RemoveContentDTO(
      categoryId: _categoryId,
      id: _id,
    );
  }
}
