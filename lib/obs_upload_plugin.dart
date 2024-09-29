
import 'obs_upload_plugin_platform_interface.dart';

class ObsUploadPlugin {
  Future<String?> getPlatformVersion() {
    return ObsUploadPluginPlatform.instance.getPlatformVersion();
  }
}
