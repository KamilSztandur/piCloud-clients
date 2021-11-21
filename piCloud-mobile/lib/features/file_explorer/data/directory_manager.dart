import 'dart:math';
import 'package:app/features/file_explorer/data/models/file_explorer_item_type.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';

class DirectoryManager {
  Future<List<FileItem>> getCurrentDirectoryItems(String path) async {
    final items = await _getRawList(path);
    final sortedItems = _sortDirectoryItemsByTypeAndName(items);

    return sortedItems;
  }

  // WARNING: Mock
  Future<List<FileItem>> _getRawList(String path) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final items = <FileItem>[];

    for (var i = 0; i < 20; i++) {
      final currentType = FileExplorerItemType.values[Random().nextInt(
        FileExplorerItemType.values.length,
      )];

      var title = currentType.toString();
      title = '${title.substring(title.indexOf('.') + 1, title.length)} $i';
      title = title[0] + title.substring(1).toLowerCase();

      items.add(
        FileItem(
          title: title,
          lastModifiedOn: DateTime.now(),
          type: currentType,
          size: 20,
          thumbnailURL: null,
        ),
      );
    }

    items.add(
      FileItem(
        title: 'Francuskie zamki długa nazwa',
        lastModifiedOn: DateTime.now(),
        type: FileExplorerItemType.image,
        size: 20,
        thumbnailURL:
            'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg',
      ),
    );

    return items;
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
