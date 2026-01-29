abstract class ChatLocalizations {
  String get aiIconSpeaking =>
      "packages/kayo_package/assets/chat/ai_icon_speaking.png";

  String get aiIcon => "packages/kayo_package/assets/chat/ai_icon.png";

  bool get showUserProfile => true;

  bool get showCloseButton => false;

  void logout();
}
