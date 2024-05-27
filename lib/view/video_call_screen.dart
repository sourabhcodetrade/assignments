import 'package:agora_ui_kit_integration/utils/constants.dart';
import 'package:agora_ui_kit_integration/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: Constants.appID,
      channelName: "test",
      tempToken: "007eJxTYJA6ZLTn4glr0foHBw+u+zzJY0m8Xvt2NYe9HKfXMsyz052pwGBgaJRimZJkYW6ZbG5iYZZmaWGZkmaRaGloYmBmkmRkkeMYktYQyMhwKyKdmZEBAkF8FoaS1OISBgYAR0IexA==",
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Video Call"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              child: AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                showNumberOfUsers: true,
                enableHostControls: true, // Add this to enable host controls
              ),
            ),
            AgoraVideoButtons(
              client: client,
              addScreenSharing: false, // Add this to enable screen sharing
            ),
          ],
        ),
      ),
    );
  }
}
