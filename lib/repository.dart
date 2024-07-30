import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutterapp/app.dart';
import 'package:testflutterapp/doctor_home_screen.dart';
import 'package:testflutterapp/livestream/live_stream_home_screen.dart';
import 'package:testflutterapp/livestream/live_stream_login.dart';
import 'package:testflutterapp/livestreammobile/live_stream_mobile_home_screen.dart';
import 'package:testflutterapp/livestreammobile/live_stream_mobile_login.dart';

Future<void> loginUser(
    String emailValue, String passwordValue, BuildContext context, String role) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    String apiUrl = 'https://api.escuelajs.co/api/v1/auth/login';
    String userEmail = emailValue;
    String password = passwordValue;
    
    final response = await http.post(Uri.parse(apiUrl),
    
        body: {"email": userEmail, "password": password});

    print(response);

    if (response.statusCode == 201) {
      var jsonBody = jsonDecode(response.body);
      final token = jsonBody['access_token'];
     
      await prefs.setString('accessToken', token);
      await prefs.setString("role", role);
      String tokenValue =  prefs.getString("accessToken")??"";
      final responseProfile = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
          headers: {"Authorization": "Bearer $tokenValue"});
         
          if(responseProfile.statusCode==200){
            final responseProfileJsonBody= jsonDecode(responseProfile.body);
            await prefs.setString("name",  responseProfileJsonBody["name"]);
           if(kIsWeb){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LiveStremHomeScreen() ),
      );

      }
     else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LiveStreamMobileHomeScreen()),
      );

     }
          }
          else{
             await prefs.clear();
              }
       
      // print('Token stored: $token');
    } else {
      prefs.clear();
      print('Login failed: ${response.body}');
    }
  } catch (ex)  {
    prefs.clear();
    

    print(ex);
  }
}

Future<void> signUpUser(String userName, String emailValue,
    String passwordValue, BuildContext context) async {
  try {
    String apiUrl = 'https://api.escuelajs.co/api/v1/users/';
    String username = userName;
    String password = passwordValue;
    String email = emailValue;

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "name": username,
        "email": email,
        "password": password,
        "avatar": "https://picsum.photos/800",
      },
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      var snackBar = const SnackBar(
        content: Text('User Created Successfully'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LiveStreamLogin()),
      );

    

    } else {
      var snackBar = const SnackBar(
        content: Text('Something Went wrong'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Login failed: ${response.body}');
    }
  } catch (ex) {
    var snackBar = SnackBar(
      content: Text(ex.toString()),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(ex);
  }
}

Future<bool> create100msTemplate() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    String apiUrl = 'https://api.100ms.live/v2/templates';
    String tokenValue = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjE1NDQ1NTAsImV4cCI6MTcyMjE0OTM1MCwianRpIjoiZDM4OWJkNzAtMDkxNS00N2U3LWIyMDgtYWM2NGQyZTNmYThjIiwidHlwZSI6Im1hbmFnZW1lbnQiLCJ2ZXJzaW9uIjoyLCJuYmYiOjE3MjE1NDQ1NTAsImFjY2Vzc19rZXkiOiI2NjkwY2VmNWFkZDEyNjUxYTAyZjg5OTQifQ.Ynfq_8kyYa1lxpBV7vaI53kO_g8UUCRwfXVbDW7c4Z4";
    final  response = await http.post(Uri.parse(apiUrl),
           headers: {"Authorization": "Bearer $tokenValue"},
    
        body: jsonEncode({
    "name": "HealthcheckApp",
    "roles": {
        "receptionArea": {
            "name": "receptionArea",
            "publishParams": {
                "allowed": ["audio", "video", "screen"],
                "audio": {
                    "bitRate": 32,
                    "codec": "opus"
                },
                "video": {
                    "bitRate": 300,
                    "codec": "vp8",
                    "frameRate": 30,
                    "width": 480,
                    "height": 360
                },
                "screen": {
                    "codec": "vp8",
                    "frameRate": 10,
                    "width": 1920,
                    "height": 1080
                },
                "simulcast": {
                    "video": {
                        "layers": [
                            {
                                "rid": "f",
                                "scaleResolutionDownBy": 1,
                                "maxBitrate": 700,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "h",
                                "scaleResolutionDownBy": 2,
                                "maxBitrate": 350,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "q",
                                "scaleResolutionDownBy": 4,
                                "maxBitrate": 100,
                                "maxFramerate": 25
                            }
                        ]
                    },
                    "screen": {}
                }
            },
            "subscribeParams": {
                "subscribeToRoles": ["receptionArea", "receptionAdmin"],
                "maxSubsBitRate": 3200,
                "subscribeDegradation": {
                    "packetLossThreshold": 25,
                    "degradeGracePeriodSeconds": 1,
                    "recoverGracePeriodSeconds": 4
                }
            },
            "permissions": {
                "sendRoomState": false,
                "pollRead": true,
                "pollWrite": true
            },
            "priority": 1,
            "maxPeerCount": 0
        },
        
         "consultationAdmin": {
            "name": "consultationAdmin",
            "publishParams": {
                "allowed": ["audio", "video", "screen"],
                "audio": {
                    "bitRate": 32,
                    "codec": "opus"
                },
                "video": {
                    "bitRate": 300,
                    "codec": "vp8",
                    "frameRate": 30,
                    "width": 480,
                    "height": 360
                },
                "screen": {
                    "codec": "vp8",
                    "frameRate": 10,
                    "width": 1920,
                    "height": 1080
                },
                "simulcast": {
                    "video": {
                        "layers": [
                            {
                                "rid": "f",
                                "scaleResolutionDownBy": 1,
                                "maxBitrate": 700,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "h",
                                "scaleResolutionDownBy": 2,
                                "maxBitrate": 350,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "q",
                                "scaleResolutionDownBy": 4,
                                "maxBitrate": 100,
                                "maxFramerate": 25
                            }
                        ]
                    },
                    "screen": {}
                }
            },
            "subscribeParams": {
                "subscribeToRoles": ["consultationAdmin", "consultationArea"],
                "maxSubsBitRate": 3200,
                "subscribeDegradation": {
                    "packetLossThreshold": 25,
                    "degradeGracePeriodSeconds": 1,
                    "recoverGracePeriodSeconds": 4
                }
            },
            "permissions": {
                 "endRoom": true,
                "removeOthers": true,
                "mute": true,
                "unmute": true,
                "changeRole": true,
                "sendRoomState": false,
                "pollRead": true,
                "pollWrite": true
            
            },
            "priority": 1,
            "maxPeerCount": 0
        },
        
         "consultationArea": {
            "name": "consultationArea",
            "publishParams": {
                "allowed": ["audio", "video", "screen"],
                "audio": {
                    "bitRate": 32,
                    "codec": "opus"
                },
                "video": {
                    "bitRate": 300,
                    "codec": "vp8",
                    "frameRate": 30,
                    "width": 480,
                    "height": 360
                },
                "screen": {
                    "codec": "vp8",
                    "frameRate": 10,
                    "width": 1920,
                    "height": 1080
                },
                "simulcast": {
                    "video": {
                        "layers": [
                            {
                                "rid": "f",
                                "scaleResolutionDownBy": 1,
                                "maxBitrate": 700,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "h",
                                "scaleResolutionDownBy": 2,
                                "maxBitrate": 350,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "q",
                                "scaleResolutionDownBy": 4,
                                "maxBitrate": 100,
                                "maxFramerate": 25
                            }
                        ]
                    },
                    "screen": {}
                }
            },
            "subscribeParams": {
                "subscribeToRoles": ["consultationAdmin", "consultationArea"],
                "maxSubsBitRate": 3200,
                "subscribeDegradation": {
                    "packetLossThreshold": 25,
                    "degradeGracePeriodSeconds": 1,
                    "recoverGracePeriodSeconds": 4
                }
            },
            "permissions": {
                 "endRoom": true,
                  "pollRead": true,
                "pollWrite": true
            
            },
            "priority": 1,
            "maxPeerCount": 0
        },

        "receptionAdmin": {
            "name": "receptionAdmin",
            "publishParams": {
                "allowed": ["audio", "video", "screen"],
                "audio": {
                    "bitRate": 32,
                    "codec": "opus"
                },
                "video": {
                    "bitRate": 300,
                    "codec": "vp8",
                    "frameRate": 30,
                    "width": 480,
                    "height": 360
                },
                "screen": {
                    "codec": "vp8",
                    "frameRate": 10,
                    "width": 1920,
                    "height": 1080
                },
                "simulcast": {
                    "video": {
                        "layers": [
                            {
                                "rid": "f",
                                "scaleResolutionDownBy": 1,
                                "maxBitrate": 700,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "h",
                                "scaleResolutionDownBy": 2,
                                "maxBitrate": 350,
                                "maxFramerate": 25
                            },
                            {
                                "rid": "q",
                                "scaleResolutionDownBy": 4,
                                "maxBitrate": 100,
                                "maxFramerate": 25
                            }
                        ]
                    },
                    "screen": {}
                }
            },
            "subscribeParams": {
                "subscribeToRoles": ["receptionAdmin", "receptionArea"],
                "maxSubsBitRate": 3200,
                "subscribeDegradation": {
                    "packetLossThreshold": 25,
                    "degradeGracePeriodSeconds": 1,
                    "recoverGracePeriodSeconds": 4
                }
            },
            "permissions": {
                "endRoom": true,
                "removeOthers": true,
                "mute": true,
                "unmute": true,
                "changeRole": true,
                "sendRoomState": false,
                "pollRead": true,
                "pollWrite": true
            },
            "priority": 1,
            "maxPeerCount": 0
        }
    },
    "settings": {
        "region": "in",
        "roomState": {
            "messageInterval": 5,
            "sendPeerList": false,
            "stopRoomStateOnJoin": true,
            "enabled": false
        }
    },
    "plugins": {
        "whiteboard": {
            "permissions": {
                "admin": ["consultationAdmin"],
                "writer": ["consultationAdmin"],
                "reader": ["consultationArea"]
            }
        }
    }
}
));

print(response.statusCode);

if(response.statusCode==200){
   var jsonBody = jsonDecode(response.body);

  prefs.setString("templateid", jsonBody["id"]);
  return true;


  


}
return false;




  }
  catch(ex){
  print(ex.toString());
  return false;
  }
   

   

   
}

Future<bool> create100msRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    String apiUrl = 'https://api.100ms.live/v2/rooms';
    String tokenValue = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjE1NDQ1NTAsImV4cCI6MTcyMjE0OTM1MCwianRpIjoiZDM4OWJkNzAtMDkxNS00N2U3LWIyMDgtYWM2NGQyZTNmYThjIiwidHlwZSI6Im1hbmFnZW1lbnQiLCJ2ZXJzaW9uIjoyLCJuYmYiOjE3MjE1NDQ1NTAsImFjY2Vzc19rZXkiOiI2NjkwY2VmNWFkZDEyNjUxYTAyZjg5OTQifQ.Ynfq_8kyYa1lxpBV7vaI53kO_g8UUCRwfXVbDW7c4Z4";
    final  response = await http.post(Uri.parse(apiUrl),
           headers: {"Authorization": "Bearer $tokenValue"},
    
        body: jsonEncode({
    "name": "HealthCheckUpAppRoom",
    "description": "This is a sample description for the room",
    "template_id": prefs.getString("templateid")
})
);
if(response.statusCode==200){
   var jsonBody = jsonDecode(response.body);

  prefs.setString("roomid", jsonBody["id"]);
  return true;


  


}
return false;




  }
  catch(ex){
  print(ex.toString());
  return false;
  }
   

}
// Future <String> createRoomCode(String roomrole) async{


//    SharedPreferences prefs = await SharedPreferences.getInstance(); 
//    String roleValue="";
//    if(roomrole=="Doctor"){
//     roleValue= "consultationAdmin";
//    }
//    if(roomrole=="Patient"){
//     roleValue="receptionArea";
//    }
//    if(roomrole=="Receptionist"){
//     roleValue="receptionAdmin";
//    }

//    try{
//     String roomId= prefs.getString('roomid') ?? "";
    
//      String apiUrl = 'https://api.100ms.live/v2/room-codes/room/$roomId/role/$roleValue';
//       String tokenValue = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjE1NDQ1NTAsImV4cCI6MTcyMjE0OTM1MCwianRpIjoiZDM4OWJkNzAtMDkxNS00N2U3LWIyMDgtYWM2NGQyZTNmYThjIiwidHlwZSI6Im1hbmFnZW1lbnQiLCJ2ZXJzaW9uIjoyLCJuYmYiOjE3MjE1NDQ1NTAsImFjY2Vzc19rZXkiOiI2NjkwY2VmNWFkZDEyNjUxYTAyZjg5OTQifQ.Ynfq_8kyYa1lxpBV7vaI53kO_g8UUCRwfXVbDW7c4Z4";
//     final  response = await http.post(Uri.parse(apiUrl),
//            headers: {"Authorization": "Bearer $tokenValue"},
// );
     

// if(response.statusCode==200){
//   print(response);
//   var jsonBody = jsonDecode(response.body);
//   print(jsonBody["code"]);
//  prefs.setString("roomcode", jsonBody["code"]);
//  return jsonBody["code"];
// }

// return "";

//    }
//    catch(ex){
//     return "";
//    }



// }

Future<String?> fetchRoomCode(String roomrole) async{
  try{
    String roleValue="";
  //   if(roomrole=="Do"){
  //    roleValue= "consultationadmin";
  //  }
  //  if(roomrole=="Patient"){
  //    roleValue="receptionarea";
  //  }
  //   if(roomrole=="Receptionist"){
  //    roleValue="receptionadmin";

  //  }

 

 String apiUrl = 'https://api.100ms.live/v2/room-codes/room/669d412b163cfbb5932d36a7?enabled=true&role=$roomrole';
      String tokenValue = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjE1NDQ1NTAsImV4cCI6MTcyMjE0OTM1MCwianRpIjoiZDM4OWJkNzAtMDkxNS00N2U3LWIyMDgtYWM2NGQyZTNmYThjIiwidHlwZSI6Im1hbmFnZW1lbnQiLCJ2ZXJzaW9uIjoyLCJuYmYiOjE3MjE1NDQ1NTAsImFjY2Vzc19rZXkiOiI2NjkwY2VmNWFkZDEyNjUxYTAyZjg5OTQifQ.Ynfq_8kyYa1lxpBV7vaI53kO_g8UUCRwfXVbDW7c4Z4";
     final  response = await http.get(Uri.parse(apiUrl),

            headers: {"Authorization": "Bearer $tokenValue"},
 );
     
     if(response.statusCode==200){
      var jsonBody = jsonDecode(response.body);
       return jsonBody["data"][0]["code"];

     }
   
      return null;
     


  }
  catch(ex){

   return null;
 
  }
}