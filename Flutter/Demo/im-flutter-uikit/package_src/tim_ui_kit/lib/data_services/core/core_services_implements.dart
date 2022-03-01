import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:tim_ui_kit/business_logic/view_models/tui_theme_view_model.dart';
import 'package:tim_ui_kit/data_services/core/core_services.dart';
import 'package:tim_ui_kit/ui/utils/color.dart';
import 'package:tim_ui_kit/ui/utils/tui_theme.dart';

import '../services_locatar.dart';

class CoreServicesImpl with CoreServices {
  V2TimUserFullInfo? _loginInfo;
  V2TimUserFullInfo? get loginUserInfo {
    return _loginInfo;
  }

  @override
  Future<bool?> init(
      {required int sdkAppID,
      required LogLevelEnum loglevel,
      required V2TimSDKListener listener}) async {
    // setupServiceLocator();
    final result = await TencentImSDKPlugin.v2TIMManager
        .initSDK(sdkAppID: sdkAppID, loglevel: loglevel, listener: listener);
    return result.data;
  }

  @override
  Future<V2TimCallback> login({
    required String userID,
    required String userSig,
  }) async {
    final result = await TencentImSDKPlugin.v2TIMManager
        .login(userID: userID, userSig: userSig);
    if (result.code == 0) {
      getUsersInfo(userIDList: [userID]).then((res) => {
            if (res.code == 0) {_loginInfo = res.data![0]}
          });
    }
    return result;
  }

  @override
  Future<V2TimCallback> logout() async {
    final result = await TencentImSDKPlugin.v2TIMManager.logout();
    return result;
  }

  @override
  Future unInit() async {
    final result = await TencentImSDKPlugin.v2TIMManager.unInitSDK();
    return result;
  }

  @override
  Future<V2TimValueCallback<List<V2TimUserFullInfo>>> getUsersInfo({
    required List<String> userIDList,
  }) {
    return TencentImSDKPlugin.v2TIMManager.getUsersInfo(userIDList: userIDList);
  }

  @override
  Future<V2TimCallback> setOfflinePushConfig({
    required double businessID,
    required String token,
    bool isTPNSToken = false,
  }) {
    return TencentImSDKPlugin.v2TIMManager
        .getOfflinePushManager()
        .setOfflinePushConfig(
            businessID: businessID, token: token, isTPNSToken: isTPNSToken);
  }

  @override
  Future<V2TimCallback> setSelfInfo({
    required V2TimUserFullInfo userFullInfo,
  }) {
    return TencentImSDKPlugin.v2TIMManager
        .setSelfInfo(userFullInfo: userFullInfo);
  }

  @override
  setTheme({required TUITheme theme}) {
    // 合并传入Theme和默认Theme
    final TUIThemeViewModel _theme = serviceLocator<TUIThemeViewModel>();
    Map<String, Color?> jsonMap = Map.from(CommonColor.defaultTheme.toJson());
    Map<String, Color?> jsonInputThemeMap = Map.from(theme.toJson());

    jsonInputThemeMap.forEach((key, value) {
      if (value != null) {
        jsonMap.update(key, (v) => value);
      }
    });
    _theme.theme = TUITheme.fromJson(jsonMap);
  }

  @override
  setDarkTheme() {
    final TUIThemeViewModel _theme = serviceLocator<TUIThemeViewModel>();
    _theme.theme = TUITheme.dark; //Dark
  }

  @override
  setLightTheme() {
    final TUIThemeViewModel _theme = serviceLocator<TUIThemeViewModel>();
    _theme.theme = TUITheme.light; //Light
  }
}