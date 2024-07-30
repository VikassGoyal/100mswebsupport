import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutterapp/iframe_screen.dart';
import 'package:testflutterapp/livestreammobile/live_stream_room.dart';
import 'package:testflutterapp/repository.dart';

class LiveStreamMobileHomeScreen extends StatefulWidget {
  const LiveStreamMobileHomeScreen({super.key});

  @override
  State<LiveStreamMobileHomeScreen> createState() => _LiveStreamMobileHomeScreenState();
}

class _LiveStreamMobileHomeScreenState extends State<LiveStreamMobileHomeScreen> {
  late Future<SharedPreferences> _prefs;
  final List<String> _roles = ['broadcaster', 'co-broadcaster', 'viewer-realtime', 'viewer-near-realtime'];
  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
   
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Center(
        child: Scaffold(
          body: FutureBuilder<SharedPreferences>(
            future: _prefs,
            builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return  const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final prefs = snapshot.data;
                final name = prefs?.getString('name') ?? '';
                final role =prefs?.getString("role")??'';
            
                if(role== _roles[0]){
                  return Column(
                    children: [
                      Text("Hi ${_roles[0]} $name"),
                      ElevatedButton(onPressed: () async{
                       String? roomCode=  await fetchRoomCode(_roles[0]);
                       if(roomCode!=null){
                        Navigator.push(context,MaterialPageRoute(
                     builder: (context) =>  LiveStreamRoom( name: name, roomCode: roomCode) 
        
                   ),);
                       }
                      }, child:  const Text("Join Room")),
                    ],
                  );
        
        
                }
                else if(role== _roles[1]){
                  return Column(
                    children: [
                      Text("Hi ${_roles[1]}, $name"),
                      ElevatedButton(onPressed: ()async {
                       String? roomCode=  await fetchRoomCode(_roles[1]);
                       if(roomCode!=null) {
                        Navigator.push(context,MaterialPageRoute(
                     builder: (context) =>   LiveStreamRoom( name: name, roomCode: roomCode)  
                   ),);
                       }
        
                      }, child:  const Text("Join Room")),
                    ],
                  );
        
        
                }
                  
                else  if(role== _roles[2]){
                  return Column(
                    children: [
                      Text("Hi ${ _roles[2]}, $name"),
                      ElevatedButton(onPressed: () async{
                        String? roomCode=  await fetchRoomCode(_roles[3]);
                       if(roomCode!=null){
                        Navigator.push(context,MaterialPageRoute(
                     builder: (context) =>   LiveStreamRoom( name: name, roomCode: roomCode) 
        
                   ),); 
                       }
        
        
                      }, child:  const Text("Join Room")),
                      
                    ],
                  );
        
        
                } 
                else  if(role== _roles[3]){
                  return Column(
                    children: [
                      Text("Hi ${ _roles[3]}, $name"),
                      ElevatedButton(onPressed: () async{
                        String? roomCode=  await fetchRoomCode(_roles[3]);
                       if(roomCode!=null){
                        Navigator.push(context,MaterialPageRoute(
                     builder: (context) =>   LiveStreamRoom( name: name, roomCode: roomCode) 
                   ),); 
                       }
        
        
                      }, child:  const Text("Join Room")),
                      
                    ],
                  );
        
        
                } 
                else{
                  return Container();
                }
                  
              
              }
            },
          ),
        ),
      ),
    );
  }
}