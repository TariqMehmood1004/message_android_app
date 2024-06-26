import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../utils/config.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({super.key, required this.callID});
  final String callID;

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appID,
      appSign: appSign,
      userID: ZIMKit().currentUser()!.baseInfo.userID,
      userName: ZIMKit().currentUser()!.baseInfo.userName,
      callID: widget.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
