import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testflutterapp/repository.dart';
import 'iframe_check.dart';
import 'package:flutter/foundation.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late Future<SharedPreferences> _prefs;
  final List<String> _roles = ['Patient', 'Doctor', 'Receptionist'];
  bool roombutton= false;
  bool joinbutton= false;
  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    roombutton= false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text("Hi $name"),
                  ElevatedButton(onPressed: () async{
                   String? roomCode=  await fetchRoomCode(_roles[0]);
                   if(roomCode!=null){
              //       Navigator.push(context,MaterialPageRoute(
              //    builder: (context) =>  (kIsWeb) ?  Iframe(roomCode) :IframeStub(roomCode)

              //  ),);
                   }
                  }, child:  const Text("Join Room")),
                ],
              );


            }
            else if(role== _roles[1]){
              return Column(
                children: [
                  Text("Hi Doctor, $name"),
                  ElevatedButton(onPressed: ()async {
                   String? roomCode=  await fetchRoomCode(_roles[1]);
                   if(roomCode!=null) {
              //       Navigator.push(context,MaterialPageRoute(
              //    builder: (context) => (kIsWeb) ?  Iframe(roomCode) :IframeStub(roomCode)
              //  ),);
                   }

                  }, child:  const Text("Join Room")),
                ],
              );


            }
              
            else  if(role== _roles[2]){
              return Column(
                children: [
                  Text("Hi Receptionist, $name"),
                  ElevatedButton(onPressed: () async{
                    String? roomCode=  await fetchRoomCode(_roles[2]);
                   if(roomCode!=null){
              //       Navigator.push(context,MaterialPageRoute(
              //    builder: (context) => (kIsWeb) ?  Iframe(roomCode) :IframeStub(roomCode)

              //  ),); 
                   }


                  }, child:  const Text("Join Room")),
                ],
              );


            } 
            else{
              return Container();
            }
              

              
              //   if(role== _roles[1]){
              //     return Column(
              //       children: [
              //         Center(child: Text('Hi $role , $name')),
              //         ElevatedButton(onPressed: () async {
              //         bool templateCreate=   await create100msTemplate();
              //         if(templateCreate){
              //           roombutton=templateCreate;
              //           setState(() {
              //          });
              //         }
                        

              //   }, child: const  Text("Create a template", style:TextStyle(color: Colors.white),)),
              //     roombutton ? ElevatedButton(onPressed: () async {
              //        joinbutton = await  create100msRoom();
              //        setState(() {

                     
              //        });




              //   }, child: const  Text("Create a room", style:TextStyle(color: Colors.white),)) : Container(),
              //  joinbutton ? ElevatedButton(onPressed: () async {
                 
              // String roomCode =  await createRoomCode(_roles[1]);
              //       roomCode.isNotEmpty ? Navigator.push(context,MaterialPageRoute(
              //   builder: (context) =>  Iframe(roomCode) 
              // ),) :  null ;


              //   }, child: const  Text("Join Link", style:TextStyle(color: Colors.white),))  : Container()],
              //     );

              //   }
              //   else if(role== _roles[0]){
              //    return  ElevatedButton(onPressed: () async {
              //    String roomCode =  await createRoomCode(_roles[0]);
              //       roomCode.isNotEmpty ? Navigator.push(context,MaterialPageRoute(
              //   builder: (context) =>  Iframe(roomCode) 
              // ),) :  null ;

              //   }, child: const  Text("Join Link", style:TextStyle(color: Colors.white),));

                  
              //   }
              //   else if(role== _roles[2]){
              //     return ElevatedButton(onPressed: () async {
              //      String roomCode =  await createRoomCode(_roles[2]);
              //       roomCode.isNotEmpty ? Navigator.push(context,MaterialPageRoute(
              //   builder: (context) =>  Iframe(roomCode) 
              // ),) :  null ;



              //   }, child: const  Text("Join Link", style:TextStyle(color: Colors.white),));
              //   }
              //   else{
              //     return Container();
              //   }
                
            
          
          }
        },
      ),
    );
  }
}
