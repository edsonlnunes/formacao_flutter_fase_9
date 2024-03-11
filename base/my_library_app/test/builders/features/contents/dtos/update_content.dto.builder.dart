import 'package:my_library_app/features/contents/dtos/update_content.dto.dart';

class UpdateContentDTOBuilder {
  final int _categoryId = 1;
  final int _id = 1;
  final bool _isChecked = true;

  static UpdateContentDTOBuilder init() => UpdateContentDTOBuilder();

  UpdateContentDTO build() {
    return UpdateContentDTO(
      categoryId: _categoryId,
      id: _id,
      isChecked: _isChecked,
    );
  }
}
