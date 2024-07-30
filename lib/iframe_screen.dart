import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'iframe_stub.dart'
    if (dart.library.html) 'web_iframe.dart';

class Iframe extends StatelessWidget {
  final String roomCode;
  final String name;

  Iframe(this.roomCode , this.name) {
    if (kIsWeb) {
      IframeFactory.registerIframeFactory(roomCode, name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100,
        child: kIsWeb ? HtmlElementView(viewType: 'iframe') : Container(),
      ),
    );
  }
}
