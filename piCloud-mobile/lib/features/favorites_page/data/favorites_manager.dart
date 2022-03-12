import 'package:app/common/extensions/file_info_dto_type.dart';
import 'package:app/common/models/file_explorer_item_type.dart';
import 'package:app/common/models/file_item.dart';
import 'package:app/common/use_cases/get_image_preview_use_case.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';

class FavoritesManager {
  const FavoritesManager(
    this._api,
    this._getImagePreviewUseCase,
  );

  final Api _api;
  final GetImagePreviewUseCase _getImagePreviewUseCase;

  Future<void> toggleFavorite(Iterable<String> fileIds) {
    return Future.wait(
      fileIds.map(
        (id) => _api.favouriteFileIdPatch(fileId: id),
      ),
    );
  }

  Future<List<FileItem>?> getCurrentDirectoryItems() async {
    final items = await _getRawList();

    if (items != null) {
      return _sortDirectoryItemsByTypeAndName(items);
    } else {
      return null;
    }
  }

  Future<List<FileItem>?> _getRawList() async {
    final fileExplorerItems = <FileItem>[];

    final result = await _api.favouriteAllGet();

    for (final dto in result.body ?? <FileInfoDTO>[]) {
      final type = dto.type.toFileExplorerItemType();
      final thumbnail = type == FileExplorerItemType.image
          ? await _getImagePreviewUseCase.invoke(dto.pubId!)
          : null;

      fileExplorerItems.add(
        FileItem(
          id: dto.pubId!,
          title: dto.name!,
          lastModifiedOn: dto.modifiedAt!,
          type: type,
          size: dto.size!.toDouble(),
          thumbnail: thumbnail,
          isFavorite: dto.isFavourite ?? false,
        ),
      );
    }
    return fileExplorerItems;
  }

  List<FileItem> _sortDirectoryItemsByTypeAndName(List<FileItem> items) {
    return items
      ..sort(
        (a, b) {
          final typeComparison = a.type.index - b.type.index;
          if (typeComparison == 0) {
            return a.title.compareTo(b.title);
          } else {
            return typeComparison;
          }
        },
      );
  }
}
