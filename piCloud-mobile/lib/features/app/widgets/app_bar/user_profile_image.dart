import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FutureBuilder(
        future: _getAvatar(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _getPicture(snapshot.data! as ImageProvider);
          } else {
            return _getPicture(const AssetImage('assets/profilepic.jpg'));
          }
        },
      ),
    );
  }

  Future<ImageProvider> _getAvatar(BuildContext context) async {
    final authManager = context.read<AuthManager>();
    final username = await authManager.getUsernameOfLoggedUser();

    try {
      final api = context.read<Api>();
      final userData = await api.userUsernameDetailsGet(username: username);
      // TODO
      throw UnimplementedError();
      // final imageId = userData.body!.profilePicturePubId!;
      // final image = await api.filesFileFileIdGet(fileId: imageId);
      // return MemoryImage(image.bodyBytes);
    } catch (exception) {
      return const AssetImage('assets/profilepic.jpg');
    }
  }

  ClipOval _getPicture(ImageProvider image) {
    return ClipOval(
      child: Image(
        fit: BoxFit.scaleDown,
        image: image,
      ),
    );
  }
}
