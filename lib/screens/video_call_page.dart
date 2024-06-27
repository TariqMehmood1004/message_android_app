import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../utils/colors.dart';
import '../utils/config.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.callID});
  final String callID;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool isTorchOn = false;
  bool hasFrontFlashlight = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
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
        TorchLight.isTorchAvailable().then((value) {
          setState(() {
            hasFrontFlashlight = value;
          });
        });
      });
    } catch (e) {
      print('Could not toggle flashlight: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  double _left = 20; // Track the left position of the FloatingActionButton
  double _top = 20; // Track the top position of the FloatingActionButton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // if (hasFrontFlashlight && !isTorchOn)
          ZegoUIKitPrebuiltCall(
            appID: appID,
            appSign: appSign,
            userID: ZIMKit().currentUser()?.baseInfo.userID ?? '',
            userName: ZIMKit().currentUser()?.baseInfo.userName ?? '',
            callID: widget.callID,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          ),

          // Custom Floating Action Button
          // if (hasFrontFlashlight)
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            top: _top + MediaQuery.of(context).padding.top + 20,
            left: _left + MediaQuery.of(context).padding.left + 20,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _left += details.delta.dx;
                  _top += details.delta.dy;
                });
              },
              child: Container(
                width: 60,
                padding: EdgeInsets.only(
                  top: 2,
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: colorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Icon(Icons.drag_handle, color: colorGray, size: 20),
                    FloatingActionButton(
                      mini: true,
                      shape: CircleBorder(),
                      backgroundColor: Colors.transparent,
                      highlightElevation: 0,
                      foregroundColor: colorWhite,
                      elevation: 0,
                      onPressed: _toggleFlashlight,
                      child: Icon(isTorchOn ? Icons.flash_off : Icons.flash_on),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          // color: colorGray,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.network(
                            height: 40,
                            width: 40,
                            'https://avatars.githubusercontent.com/u/116074810?v=4'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
