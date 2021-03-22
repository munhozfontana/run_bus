import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GSMServices.provideAPIKey("AIzaSyBRZKRa3kVeBT62_-DqhjqKCrI4FGkJwQM")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
