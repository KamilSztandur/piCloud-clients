import 'package:app/features/app/widgets/app_bar/appbar.dart';
import 'package:app/features/app/widgets/app_bar/selection_app_bar.dart';
import 'package:app/features/app/widgets/navigation_bar/bottom_navigation_bar.dart';
import 'package:app/features/drawer/main_drawer.dart';
import 'package:app/features/file_explorer/presentation/widgets/add_media/add_media_floating_button.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_view.dart';
import 'package:app/features/file_explorer/presentation/widgets/switch_view_button.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class FileExplorerPage extends StatefulWidget {
  const FileExplorerPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  _FileExplorerPageState createState() => _FileExplorerPageState();
}

class _FileExplorerPageState extends State<FileExplorerPage> {
  Selection? selection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getBar(),
      drawer: const MainDrawer(),
      body: FileExplorerView(
        path: widget.path,
        selectionChanged: (selection) => setState(() {
          this.selection = selection;
        }),
      ),
      floatingActionButton: _getAddMediaButtonIfNeeded(),
      bottomNavigationBar: const PICloudBottomNavigationBar(),
    );
  }

  bool _isSelecting() {
    if (selection != null && selection!.amount > 0) {
      return true;
    } else {
      return false;
    }
  }

  String _getTitle() {
    if (widget.path == '/') {
      return 'Files';
    } else {
      var directoryName = widget.path.substring(0, widget.path.length - 1);
      directoryName = directoryName.split('/').last;

      return directoryName;
    }
  }

  PreferredSizeWidget _getBar() {
    if (_isSelecting()) {
      return SelectionAppBar(
        selection: selection ?? DragSelectGridViewController().value,
      );
    } else {
      return PICloudAppBar(
        title: _getTitle(),
        actions: [
          SwitchViewButton(
            viewSwitched: () => setState(() {}),
          ),
        ],
      );
    }
  }

  Widget _getAddMediaButtonIfNeeded() {
    return (selection != null && selection!.amount > 0)
        ? const SizedBox()
        : const AddMediaButton();
  }
}
