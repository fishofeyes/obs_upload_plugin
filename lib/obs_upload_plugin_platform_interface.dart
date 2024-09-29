import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'obs_upload_plugin_method_channel.dart';

abstract class ObsUploadPluginPlatform extends PlatformInterface {
  /// Constructs a ObsUploadPluginPlatform.
  ObsUploadPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ObsUploadPluginPlatform _instance = MethodChannelObsUploadPlugin();

  /// The default instance of [ObsUploadPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelObsUploadPlugin].
  static ObsUploadPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ObsUploadPluginPlatform] when
  /// they register themselves.
  static set instance(ObsUploadPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
