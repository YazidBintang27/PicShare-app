import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyBsSlInKCoMoT6dIlvvxz63uyMK4aJEPSQ")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
