import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tim_ui_kit/i18n/strings.g.dart';

class I18nUtils {
  // use: final I18nUtils ttBuild = I18nUtils(context);
  I18nUtils._internal(BuildContext context){
    _init(context);
  }
  factory I18nUtils(BuildContext context) => _instance(context);
  static I18nUtils _instance(BuildContext context) => I18nUtils._internal(context);

  Map<String, dynamic> zhMap = {};
  Map zhMapRevert = {};
  RegExp expForParameterOut = new RegExp(r"{{[^]+}}");
  RegExp expForParameter = new RegExp(r"(?<=\{{)[^}]*(?=\}})");
  late final t;

  void _init(BuildContext context){
    t = getI18NBuild(context);
    zhMap = jsonDecode(zhJson);
    zhMapRevert = revertMap(zhMap);
  }

  String imt(String value) {
    String currentKey = zhMapRevert[value] ?? getKeyFromMap(zhMap, value) ?? "";
    String translatedValue = t[currentKey] ?? "文本错误";
    return translatedValue;
  }

  Function imt_para(String template, String value) {
    // 调用模板：imt_para("已选：{{addType}}",'已选：${addType}')(addType: addType)
    final originTemplate = template.replaceAllMapped(expForParameterOut, (Match m) => replaceParameterForTemplate(m));
    final originKey = zhMapRevert[originTemplate] ?? getKeyFromMap(zhMap, originTemplate) ?? "";
    final Function translatedValueFunction = t[originKey] ?? textErrorFunction;
    return translatedValueFunction;
  }

  String replaceParameterForTemplate(Match value){
    final String? parameter = expForParameter.stringMatch(value[0] ?? "");
    return "\${${parameter}}";
  }

  static String textErrorFunction ([String? option]){
    return "文本错误";
  }

  static String getKeyFromMap(Map map, String key){
    String currentKey = "";
    for(String tempKey in map.keys){
      if(map[tempKey] == key){
        currentKey = tempKey;
        break;
      }
    }
    return currentKey;
  }

  static Map revertMap(Map map){
    final Map<String, String> newMap = new Map();
    for(String tempKey in map.keys){
      newMap[map[tempKey]] = tempKey;
    }
    return newMap;
  }

  String getCurrentLanguage(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  Map i18nLanguageMap = {
    "en": AppLocale.en.build(),
    "zh": AppLocale.zh.build(),
  };

  getI18NBuild(BuildContext context) {
    return i18nLanguageMap[getCurrentLanguage(context)] ??  AppLocale.en.build();
  }

  final zhJson = '''{"k_1fdhj9g":"该版本不支持此消息","k_06pujtm":"同意任何用户添加好友","k_0gyhkp5":"需要验证","k_121ruco":"拒绝任何人加好友","k_05nspni":"自定义字段","k_03fchyy":"群头像","k_03i9mfe":"群简介","k_03agq58":"群名称","k_039xqny":"群通知","k_003tr0a":"群主","k_1xd7osu":"\${s}为","k_1v6kvhw":"<\${opUserNickName}>修改","k_1qf3fnb":"<\${opUserNickName}>退出群聊","k_176c8nz":"邀请<\${invitedMemberString}>加入群组","k_0cely6r":"将<\${invitedMemberString}>踢出群组","k_1raprm9":"用户<\${joinedMemberString}>加入了群聊","k_0wn1wy1":"系统消息\${operationType}","k_002wddw":"禁言","k_0got6f7":"解除禁言","k_0nj3nkq":"\${userName} 被","k_1uaqed6":"[自定义]","k_0z2z7rx":"[语音]","k_0y39ngu":"[表情]","k_0nckgoh":"[文件] \${fileName}","k_0y1a2my":"[图片]","k_0z4fib8":"[视频]","k_0y24mcg":"[位置]","k_0pewpd1":"[聊天记录]","k_13s8d9p":"未知消息","k_003qkx2":"日历","k_003n2pz":"相机","k_03idjo0":"联系人","k_003ltgm":"位置","k_02k3k86":"麦克风","k_003pm7l":"相册","k_15ao57x":"相册写入","k_164m3jd":"本地存储","k_1ut348h":"“IM云通信”想访问您的\${yoursItem}","k_03r6qyx":"我们需要您的同意才能获取信息","k_02noktt":"不允许","k_00043x4":"好","k_003qzac":"昨天","k_003r39d":"前天","k_03ibg5h":"星期一","k_03i7hu1":"星期二","k_03iaiks":"星期三","k_03el9pa":"星期四","k_03i7ok1":"星期五","k_03efxyg":"星期六","k_03fqp9o":"星期天","k_003q7ba":"下午","k_003q7bb":"上午","k_0fh0id2":"昨天 \${yesterday}","k_0bobr6r":"\${diffMinutes} 分钟前","k_003pu3h":"现在","k_002rflt":"删除","k_03ezhho":"已复制","k_11ctfsz":"暂未实现","k_003q5fi":"复制","k_003prq0":"转发","k_002r1h2":"多选","k_003j708":"引用","k_003pqpr":"撤回","k_1hbjg5g":"[群系统消息]","k_03tvswb":"[未知消息]","k_0gt5q2o":"\${displayName}撤回了一条消息","k_0003z7x":"您","k_002wfe4":"已读","k_002wjlg":"未读","k_1jxdqeu":"发送中...","k_0uu95o6":"“IM云通信”暂不可以打开此类文件，你可以使用其他应用打开并预览","k_003nevv":"取消","k_001nmhu":"用其他应用打开","k_0pytyeu":"图片保存成功","k_0akceel":"图片保存失败","k_105682d":"图片加载失败","k_003rk1s":"保存","k_04a0awq":"[语音消息]","k_0pzwbmg":"视频保存成功","k_0aktupv":"视频保存失败","k_105c3y3":"视频加载失败","k_176rzr7":"聊天记录","k_002r305":"发送","k_003kcka":"照相","k_002s86q":"视频","k_003n8b0":"拍摄","k_003kt0a":"相片","k_003tnp0":"文件","k_0h22snw":"语音通话","k_003km5r":"名片","k_03cfe3p":"戳一戳","k_0ylosxn":"自定义消息","k_0jhdhtp":"发送失败,视频不能大于100MB","k_1i3evae":"选择成功\${successPath}","k_0gx7vl6":"按住说话","k_0am7r68":"手指上滑，取消发送","k_13dsw4l":"松开取消","k_15jl6qw":"说话时间太短!","k_15dlafd":"逐条转发","k_15dryxy":"合并转发","k_1eyhieh":"确定删除已选消息","k_17fmlyf":"清除聊天","k_0dhesoz":"取消置顶","k_002sk7x":"置顶","k_1s03bj1":"\${messageString}[有人@我]","k_050tjt8":"\${messageString}[@所有人]","k_003kfai":"未知","k_13dq4an":"自动审批","k_0l13cde":"管理员审批","k_11y8c6a":"禁止加群","k_16payqf":"加群方式","k_0vzvn8r":"修改群名称","k_003rzap":"确定","k_003ngex":"完成","k_038lh6u":"群管理","k_0k5wyiy":"设置管理员","k_0goiuwk":"全员禁言","k_1g889xx":"全员禁言开启后，只允许群主和管理员发言。","k_0wlrefq":"添加需要禁言的群成员","k_0goox5g":"设置禁言","k_08daijh":"成功取消管理员身份","k_1fd5tta":"管理员 (\${adminNum}/10)","k_0k5u935":"添加管理员","k_03enyx5":"群成员","k_03erpei":"管理员","k_0qi9tno":"群主、管理员","k_003kv3v":"搜索","k_01z3dft":"群成员(\${groupMemberNum}人)","k_1vhgizy":"\${memberCount}人","k_0ef2a12":"修改我的群昵称","k_1aajych":"仅限中文、字母、数字和下划线，2-20个字","k_137pab5":"我的群昵称","k_002vxya":"编辑","k_0ivim6d":"暂无群公告","k_03eq6cn":"群公告","k_03gu05e":"聊天室","k_03b4f3p":"会议群","k_03avj1p":"公开群","k_03asq2g":"工作群","k_03b3hbi":"未知群","k_03es1ox":"群类型","k_003mz1i":"同意","k_003lpre":"拒绝","k_003qgkp":"性别","k_0003v6a":"男","k_00043x2":"女","k_11zgnfs":"个人资料","k_003qk66":"头像","k_003lhvk":"昵称","k_003ps50":"账号","k_15lx52z":"个性签名","k_003m6hr":"生日","k_03bcjkv":"未设置","k_11s0gdz":"修改昵称","k_0p3j4sd":"仅限中字、字母、数字和下划线","k_15lyvdt":"修改签名","k_0vylzjp":"这个人很懒，什么也没写","k_1hs7ese":"等上线再改这个","k_03exjk7":"备注名","k_0s3skfd":"加入黑名单","k_17fpl3y":"置顶聊天","k_0p3b31s":"修改备注名","k_0003y9x":"无","k_1h42emf":"个性签名: \${signature}","k_1tez2xl":"暂无个性签名","k_0vdrbki":"与\${receiver}的聊天记录","k_0vjj2kp":"群聊的聊天记录","k_003n2rp":"选择","k_1m9exwh":"最近联系人","k_119nwqr":"输入不能为空"}''';
}