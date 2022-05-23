import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:health_care/config/styles.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "0b38227c07ae42f49a365c09b43aa742",
      channelName: "abc",
      tempToken: "0060b38227c07ae42f49a365c09b43aa742IACe548QuPeV+Rh42/tKE7vcwZiq9DPgGsqrPPl4bKa+5sJBJDUAAAAAEAASigVR61aNYgEAAQDrVo1i"
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

// Initialize the Agora Engine
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Appointment", style: listTileTitle,),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                  client: client,
                layoutType: Layout.floating,
                showNumberOfUsers: true,
              ),
              AgoraVideoButtons(
                client: client,
                enabledButtons: [
                  BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.toggleMic
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
