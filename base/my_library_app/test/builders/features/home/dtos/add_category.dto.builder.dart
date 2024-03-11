
import 'package:my_library_app/features/home/dtos/add_category.dto.dart';

class AddCategoryDTOBuilder {
  final String _name = 'any_name';
  final String _filePath = 'any_file_path';

  static AddCategoryDTOBuilder init() => AddCategoryDTOBuilder();

  AddCategoryDTO build() {
    return AddCategoryDTO(
      name: _name,
      filePath: _filePath,
    );
  }
}
