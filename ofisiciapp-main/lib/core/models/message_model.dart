class MessageModel {
  String text;
  int date;
  bool sendByMe;
  String? file;
  MessageModel(
      {required this.text,
      required this.date,
      required this.sendByMe,
      this.file});
}
