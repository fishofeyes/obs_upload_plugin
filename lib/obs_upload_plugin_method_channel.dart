import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'obs_upload_plugin_platform_interface.dart';

/// An implementation of [ObsUploadPluginPlatform] that uses method channels.
class MethodChannelObsUploadPlugin extends ObsUploadPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('obs_upload_plugin');
  final eventChannel = const EventChannel("obs_upload_plugin/upload");

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Stream<Map<String, dynamic>> upload(String path) {
    return eventChannel.receiveBroadcastStream({"path": path}).map((e) => e as Map<String, dynamic>);
  }

  @override
  Future<void> init(String ak, String sk, String endPoint) async {
    await methodChannel.invokeMethod(
      "init",
      {"ak": ak, "sk": sk, "endPoint": endPoint},
    );
  }
}
