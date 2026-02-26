
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:price_updating/local_storage/storage_key.dart';
import 'package:price_updating/utils/logger.dart';

final Logger log = logger(LocalStorage);

class LocalStorage {
  static void saveAccAsDev() async {
    GetStorage().write(StorageKey.isDevkey, true);
  }

  static bool isDevAcc() {
    return GetStorage().read(StorageKey.isDevkey) ?? false;
  }

  static Future<void> saveApiToken({required String token}) async {
    final box = GetStorage();
    await box.write(StorageKey.apiToken, token);
    _message(
      'Write',
      'Api key => ${box.read(StorageKey.apiToken) ?? 'not saved'}',
    );
  }

  static Future<void> saveUserId({required int id}) async {
    final box = GetStorage();
    await box.write(StorageKey.userId, id.toString());
    _message(
      'Write',
      'User Id => ${box.read(StorageKey.userId) ?? 'not saved'}',
    );
  }

  static Future<void> saveDeviceToken({required String token}) async {
    final box = GetStorage();
    await box.write(StorageKey.deviceToken, token);
    _message(
      'Write',
      'Device Token => ${box.read(StorageKey.deviceToken) ?? 'not saved'}',
    );
  }

  static Future<void> saveOnBoardDone({required bool isOnBoardDone}) async {
    final box = GetStorage();
    await box.write(StorageKey.onBoardDoneKey, isOnBoardDone);
    _message(
      'Write',
      "On board done saved in local storage, value: ${box.read(StorageKey.onBoardDoneKey) ?? false}",
    );
  }

  static String? getApiToken() {
    String? data = GetStorage().read(StorageKey.apiToken);
    _message(
      'Read',
      'Api Token: ${data ?? "##Token is null###"}',
    );
    return data;
  }

  static String? getUserId() {
    String? data = GetStorage().read(StorageKey.userId);
    _message(
      'Read',
      'User: ${data ?? "##User id is null###"}',
    );
    return data;
  }

  static String? getDeviceToken() {
    String? data = GetStorage().read(StorageKey.deviceToken);
    _message(
      'Read',
      'Device token: ${data ?? "##Token is null###"}',
    );
    return data;
  }

  static bool isApiTokenAvailable() {
    return GetStorage().hasData(StorageKey.apiToken);
  }

  static bool isOnBoardDone() {
    bool data = GetStorage().read(StorageKey.onBoardDoneKey) ?? false;
    _message(
      'Read',
      'Is On board done => $data',
    );
    return data;
  }

  static Future<void> logout() async {
    await GetStorage().remove(StorageKey.apiToken);
    await GetStorage().remove(StorageKey.isDevkey);
    await GetStorage().remove(StorageKey.userId);

    _message(
      'Log out',
      'Api key => ${GetStorage().read(StorageKey.apiToken) ?? 'Api Key Removed'}',
    );
  }

  static _message(String status, String message) {
    log.i('|📍📍📍|---- [[ $status ]] method details start ----|📍📍📍|');

    log.i(message);

    log.i('|📍📍📍|---- [[ $status ]] method details ended ----|📍📍📍|');
  }
}
