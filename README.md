# testflutterapp
The 100ms web support includes screens for user creation, login, home, and a prebuilt view  of 100ms that varies depending on the platform, either mobile or web. The home screen features a "Join" button, allowing users to join a live streaming room based on the role they select when logging into the Flutter app. The 100ms live streaming service offers various features such as open chat, private chat, quizzes, polls, stream recording, a hand raise option, and additional functionalities tailored to the user's chosen role in the room.
## Key Features
Login and Role Selection: Users can log into the app using their email and password. The app provides an option to choose their role for the live stream, such as broadcaster, co-broadcaster, real-time viewer, near real-time viewer, or viewer on stage.
## Design Patterns and Decisions
- 100ms for Flutter Web App: To integrate 100ms with a Flutter web app, we use an iframe approach. The room code is fetched via an API call from 100ms server side, based on the role selected during login. The app then passes the room link along with the room code to the iframe. Upon joining, the app requests permission to access the camera and microphone. Once permissions are granted, the UI is displayed according to the user's role.
- 100ms for Mobile App: For the 100ms mobile app, we use the hms_room_kit Flutter package. We conditionally check if the      platform is mobile and create a different home screen accordingly. This package provides components that enable us to efficiently use 100ms live streaming functionality. The rest of the functionality is similar to the web view: users log in, select a role to join the room, and fetch the room code via an API call, which is then provided to the components offered by the package.

- For 100ms WebView Demo Video open below link
  
  https://drive.google.com/file/d/16YyBirkCEg-21gjwFLWI3kxtLt7m7X3d/view?usp=sharing

- For 100ms Web View and mobile Demo Video open below link
    
  https://drive.google.com/file/d/1iWR3351idLC33V_RfOFD_krw4h8rfl5P/view?usp=sharing
  
  


For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
