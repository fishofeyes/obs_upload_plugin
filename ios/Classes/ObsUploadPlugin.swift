import Flutter
import UIKit
import OBS

public class ObsUploadPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "obs_upload_plugin", binaryMessenger: registrar.messenger())
    let instance = ObsUploadPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "init":
        let arg = call.arguments as! [String: String]
        let ak = arg["ak"]!
        let sk = arg["sk"]!
        let endPoint = arg["endPoint"]!
        let provider = OBSStaticCredentialProvider.init(accessKey: ak, secretKey: sk)
        let config = OBSServiceConfiguration.init(url: URL(string: endPoint)!, credentialProvider: provider)
        let client = OBSClient.init(configuration: config)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
