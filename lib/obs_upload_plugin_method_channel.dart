import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'obs_upload_plugin_platform_interface.dart';

/// An implementation of [ObsUploadPluginPlatform] that uses method channels.
class MethodChannelObsUploadPlugin extends ObsUploadPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('obs_upload_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
