import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchViewButton extends StatefulWidget {
  const SwitchViewButton({
    Key? key,
    required this.viewSwitched,
  }) : super(key: key);

  final VoidCallback viewSwitched;

  @override
  _SwitchViewButtonState createState() => _SwitchViewButtonState();
}

class _SwitchViewButtonState extends State<SwitchViewButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getIcon(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return IconButton(
            onPressed: _onSwitchPressed,
            icon: Icon(
              snapshot.data! as IconData,
              color: Colors.white,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<IconData> _getIcon() async {
    final prefs = await SharedPreferences.getInstance();
    final viewValue = prefs.getString('preferredView');

    if (viewValue != null) {
      switch (viewValue) {
        case 'tiles':
          return Icons.view_list_outlined;
        case 'list':
          return Icons.grid_view_outlined;
        default:
        //Ignore
      }
    }

    return Icons.visibility;
  }

  Future<void> _onSwitchPressed() async {
    final prefs = await SharedPreferences.getInstance();
    const preferredViewSettingKey = 'preferredView';

    final currentValue = prefs.getString(preferredViewSettingKey);
    if (currentValue != null) {
      switch (currentValue) {
        case 'tiles':
          await prefs.setString(preferredViewSettingKey, 'list');
          widget.viewSwitched();
          break;

        case 'list':
          await prefs.setString(preferredViewSettingKey, 'tiles');
          widget.viewSwitched();
          break;

        default:
        //Ignore
      }
    }
  }
}
