// auth.dart
import 'package:zego_zimkit/zego_zimkit.dart';

class Auth {
  static Future<void> login(String userID, String userName) async {
    await ZIMKit().connectUser(
        id: userID,
        name: userName,
        avatarUrl:
            'https://cdn-icons-png.freepik.com/512/13/13870.png?uid=R82274583&ga=GA1.1.1189231132.1719295747');
  }

  static Future<void> logout() async {
    await ZIMKit().disconnectUser();
  }
}
