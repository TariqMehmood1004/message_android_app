import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../utils/config.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.callID, required this.cameras});
  final String callID;
  final List<CameraDescription> cameras;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool isTorchOn = false;
  bool hasFrontFlash = false;

  @override
  void initState() {
    super.initState();
    checkFrontFlash();
  }

  Future<void> checkFrontFlash() async {
    for (final camera in widget.cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        CameraController controller =
            CameraController(camera, ResolutionPreset.high);
        try {
          await controller.initialize();
          if (controller.value.flashMode != FlashMode.off) {
            setState(() {
              hasFrontFlash = true;
            });
          }
          await controller.dispose();
        } catch (e) {
          print('Error checking front flash: $e');
        }
        break;
      }
    }
  }

  Future<void> _toggleFlashlight() async {
    try {
      if (isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isTorchOn = !isTorchOn;
      });
    } catch (e) {
      print('Could not toggle flashlight: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ZegoUIKitPrebuiltCall(
          appID: appID,
          appSign: appSign,
          userID: ZIMKit().currentUser()?.baseInfo.userID ?? '',
          userName: ZIMKit().currentUser()?.baseInfo.userName ?? '',
          callID: widget.callID,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
        ),
        if (hasFrontFlash)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleFlashlight,
              child: Icon(isTorchOn ? Icons.flash_off : Icons.flash_on),
            ),
          ),
      ],
    );
  }
}
