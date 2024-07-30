import 'package:flutter/material.dart';
import 'package:hms_room_kit/hms_room_kit.dart';

class LiveStreamRoom extends StatefulWidget {
  final String name;
  final String roomCode;
  const LiveStreamRoom( { required this.name, required this.roomCode ,  super.key});

  @override
  State<LiveStreamRoom> createState() => _LiveStreamRoomState();
}

class _LiveStreamRoomState extends State<LiveStreamRoom> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: HMSPrebuilt(
    roomCode: widget.roomCode,
    options: HMSPrebuiltOptions(userName: widget.name, userId: Constant.authToken, endPoints: {}),
    onLeave: (){
      print("room leave");
      print(Constant.authToken);
    },
)
    );
  }
}