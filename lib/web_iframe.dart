// web_iframe.dart
import 'dart:html' as html;
import 'dart:ui' as ui;

class IframeFactory {
  static void registerIframeFactory(String roomCode , String name) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('iframe', (int viewId) {
      var iframe = html.IFrameElement()
        ..allow = 'camera; microphone; display-capture; geolocation; notification;'
        ..src = 'https://vikas-livestream-2240.app.100ms.live/streaming/meeting/$roomCode?userId="12345"&name=${name}'
        ..style.border = 'none'; // Optional: Remove border from iframe

      return iframe;
    });
  }
}
