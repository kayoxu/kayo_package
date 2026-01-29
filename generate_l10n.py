import json
import os

base_path = "lib/l10n/arb"
os.makedirs(base_path, exist_ok=True)

# Base English template
template = {
  "@@locale": "en",
  "cancel": "Cancel",
  "done": "Done",
  "month1": "January",
  "month2": "February",
  "month3": "March",
  "month4": "April",
  "month5": "May",
  "month6": "June",
  "month7": "July",
  "month8": "August",
  "month9": "September",
  "month10": "October",
  "month11": "November",
  "month12": "December",
  "monthShort1": "Jan.",
  "monthShort2": "Feb.",
  "monthShort3": "Mar.",
  "monthShort4": "Apr.",
  "monthShort5": "May",
  "monthShort6": "Jun",
  "monthShort7": "Jul.",
  "monthShort8": "Aug.",
  "monthShort9": "Sep.",
  "monthShort10": "Oct.",
  "monthShort11": "Nov.",
  "monthShort12": "Dec.",
  "week1": "Monday",
  "week2": "Tuesday",
  "week3": "Wednesday",
  "week4": "Thursday",
  "week5": "Friday",
  "week6": "Saturday",
  "week7": "Sunday",
  "weekShort1": "Mon",
  "weekShort2": "Tue",
  "weekShort3": "Wed",
  "weekShort4": "Thur",
  "weekShort5": "Fri",
  "weekShort6": "Sat",
  "weekShort7": "Sun",
  "selectTimeText": "Select Time",
  "selectTimeRangeText": "Select Time Range",
  "startTimeText": "Start Time",
  "endTimeText": "End Time",
  "endTimeGreaterStartTimeText": "The end time cannot be earlier than the start time",
  "noMessagesToStartNewChat": "Current chat is empty, cannot start a new chat",
  "startNewChatFailed": "Failed to create new chat",
  "deleteSessionTitle": "Delete Session",
  "deleteSessionConfirm": "Are you sure you want to delete this session?",
  "delete": "Delete",
  "deleteSessionFailed": "Failed to delete session",
  "loadSessionFailed": "Failed to load session",
  "newChat": "New Chat",
  "chatHistory": "Chat History",
  "mine": "Mine",
  "startNewChatHint": "Start a new chat!",
  "startNewChatHintInput": "Type a message",
  "sendFailed": "Failed to send message",
  "session": "Session",
  "userLoginExit": "Log Out"
}

languages = {
    "es": {"cancel": "Cancelar", "done": "Hecho", "selectTimeText": "Seleccionar hora", "newChat": "Nuevo chat", "chatHistory": "Historial", "mine": "Mío"},
    "fr": {"cancel": "Annuler", "done": "Terminé", "selectTimeText": "Sélectionner l'heure", "newChat": "Nouveau chat", "chatHistory": "Historique", "mine": "Mien"},
    "de": {"cancel": "Abbrechen", "done": "Fertig", "selectTimeText": "Zeit wählen", "newChat": "Neuer Chat", "chatHistory": "Chat-Verlauf", "mine": "Mein"},
    "it": {"cancel": "Annulla", "done": "Fatto", "selectTimeText": "Seleziona ora", "newChat": "Nuova chat", "chatHistory": "Cronologia", "mine": "Mio"},
    "pt": {"cancel": "Cancelar", "done": "Feito", "selectTimeText": "Selecionar hora", "newChat": "Novo chat", "chatHistory": "Histórico", "mine": "Meu"},
    "ru": {"cancel": "Отмена", "done": "Готово", "selectTimeText": "Выбрать время", "newChat": "Новый чат", "chatHistory": "История", "mine": "Мой"},
    "ja": {"cancel": "キャンセル", "done": "完了", "selectTimeText": "時間を選択", "newChat": "新しいチャット", "chatHistory": "チャット履歴", "mine": "私の"},
    "ko": {"cancel": "취소", "done": "완료", "selectTimeText": "시간 선택", "newChat": "새 채팅", "chatHistory": "채팅 기록", "mine": "나의"},
    "ar": {"cancel": "إلغاء", "done": "تم", "selectTimeText": "تحديد الوقت", "newChat": "محادثة جديدة", "chatHistory": "سجل المحادثة", "mine": "لي"},
    "hi": {"cancel": "रद्द करें", "done": "ho gaya", "selectTimeText": "समय चुनें", "newChat": "नई चैट", "chatHistory": "चैट इतिहास", "mine": "मेरा"},
    "tr": {"cancel": "İptal", "done": "Tamam", "selectTimeText": "Zaman Seç", "newChat": "Yeni Sohbet", "chatHistory": "Sohbet Geçmişi", "mine": "Benim"},
    "vi": {"cancel": "Hủy", "done": "Xong", "selectTimeText": "Chọn thời gian", "newChat": "Cuộc trò chuyện mới", "chatHistory": "Lịch sử trò chuyện", "mine": "Của tôi"},
    "th": {"cancel": "ยกเลิก", "done": "เสร็จสิ้น", "selectTimeText": "เลือกเวลา", "newChat": "แชทใหม่", "chatHistory": "ประวัติการแชท", "mine": "ของฉัน"},
    "id": {"cancel": "Batal", "done": "Selesai", "selectTimeText": "Pilih Waktu", "newChat": "Obrolan Baru", "chatHistory": "Riwayat Obrolan", "mine": "Milik Saya"},
    "ms": {"cancel": "Batal", "done": "Selesai", "selectTimeText": "Pilih Masa", "newChat": "Sembang Baru", "chatHistory": "Sejarah Sembang", "mine": "Saya"},
    "bn": {"cancel": "বাতিল", "done": "সম্পন্ন", "selectTimeText": "সময় নির্বাচন করুন", "newChat": "নতুন চ্যাট", "chatHistory": "চ্যাট ইতিহাস", "mine": "আমার"},
    "nl": {"cancel": "Annuleren", "done": "Klaar", "selectTimeText": "Selecteer tijd", "newChat": "Nieuwe chat", "chatHistory": "Chatgeschiedenis", "mine": "Mijn"},
    "pl": {"cancel": "Anuluj", "done": "Gotowe", "selectTimeText": "Wybierz czas", "newChat": "Nowy czat", "chatHistory": "Historia czatu", "mine": "Mój"},
    "sv": {"cancel": "Avbryt", "done": "Klar", "selectTimeText": "Välj tid", "newChat": "Ny chatt", "chatHistory": "Chatthistorik", "mine": "Min"},
    "uk": {"cancel": "Скасувати", "done": "Готово", "selectTimeText": "Вибрати час", "newChat": "Новий чат", "chatHistory": "Історія чату", "mine": "Мій"}
}

for lang, trans in languages.items():
    content = template.copy()
    content["@@locale"] = lang
    for key, val in trans.items():
        if key in content:
            content[key] = val
    
    file_path = os.path.join(base_path, f"kayo_package_{lang}.arb")
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(content, f, indent=2, ensure_ascii=False)
    print(f"Generated {file_path}")
