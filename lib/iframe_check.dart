

// Conditionally import the appropriate file based on the platform

// platform_implementation.dart
export 'iframe_screen.dart' if (dart.library.html) 'iframe_screen.dart';
export 'iframe_stub.dart' if (dart.library.io) 'iframe_stub.dart';

