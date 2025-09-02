// ignore_for_file: avoid_print

import 'dart:io';

//run it => dart tools/fix_run.dart

//issues
//not working if flutter not added to path

// flutter path or just type 'flutter' if added to path
const flutter = 'flutter';
final appDir = Directory(
  Directory.current.path
      .replaceAll('/tools', '')
      .replaceAll('/fix_run.dart', ''),
);

String? macUserName;

void main(List<String> arguments) async {
  final sp = Stopwatch()..start();

  macUserName = tryDo<String?>(
      () => Process.runSync('whoami', []).stdout.toString().trim());

  tryDo(() => renameXcuserdata());
  tryDo(() => deletePodfileLock());
  tryDo(() => fixPodFile());
  tryDo(() => runFlutterClean());
  tryDo(() => runPubGet());
  tryDo(() => runPod());

  print('Done in ${sp.elapsedMilliseconds} ms');

  // tryDo(() => runApp());
}

void renameXcuserdata() {
  if (!Platform.isMacOS) return;
  if (macUserName == null) return;

  final xcuserdataDir = Directory(
      '${appDir.path}/ios/Runner.xcodeproj/xcuserdata/hassan.xcuserdatad');

  if (xcuserdataDir.existsSync()) {
    Directory(xcuserdataDir.path.replaceAll('hassan', macUserName!))
        .createSync(recursive: true);

    final files = xcuserdataDir.listSync(recursive: true);

    for (final f in files) {
      if (f is File) {
        File(f.path.replaceAll('hassan', macUserName!))
          ..createSync(recursive: true)
          ..writeAsStringSync(
            f.readAsStringSync(),
          );
      }
    }

    xcuserdataDir.delete(recursive: true);
  }

  print('Xcuserdata renamed');
}

void deletePodfileLock() {
  if (!Platform.isMacOS) return;

  final podfileLock = File('${appDir.path}/ios/Podfile.lock');

  if (podfileLock.existsSync()) {
    podfileLock.deleteSync();

    print('Podfile.lock deleted');
  }
}

void fixPodFile() {
  if (!Platform.isMacOS) return;

  final podFile = File('${appDir.path}/ios/podfile');
  podFile.writeAsStringSync(
      podFile.readAsStringSync().split('post_install').first +
          r'''
post_install do |installer|
  installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
     config.build_settings['ENABLE_BITCODE'] = 'NO'
         config.build_settings['SWIFT_VERSION'] = '5.0'
         config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
         config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
         config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
         config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
         config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
         xcconfig_path = config.base_configuration_reference.real_path
         xcconfig = File.read(xcconfig_path)
         xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
         File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
               config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
                 '$(inherited)',
                 'PERMISSION_NOTIFICATIONS=1 PERMISSION_MICROPHONE=1',
               ]
      end
    flutter_additional_ios_build_settings(target)
  end
end''');

  print('PodFile Fix');
}

void runFlutterClean() {
  Process.runSync(flutter, ['clean']);

  print('Flutter cleaned');
}

void runPubGet() {
  Process.runSync(flutter, ['pub', 'get']);

  print('Flutter pub get');
}

void runPod() {
  if (!Platform.isMacOS) return;

  final podfile = File('${appDir.path}/ios/Podfile');

  if (podfile.existsSync()) {
    Process.runSync(
      'pod',
      ['install', '--repo-update'],
      workingDirectory: '${appDir.path}/ios',
    );

    print('Pod installed');
  }
}

void runApp() {
  print('Flutter run');

  Process.runSync(flutter, ['run', 'lib/main_staging.dart']);
}

T? tryDo<T>(T Function() function) {
  try {
    return function.call();
  } catch (e, s) {
    var frames = s.toString().split("\n");
    print(frames[3]);

    return null;
  }
}
