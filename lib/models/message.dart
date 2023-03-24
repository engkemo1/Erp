class Message {
  String? message;
  String? subMessage;

  Message();

  Message.fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.subMessage = json['subMessage'];
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'subMessage': subMessage,
      };
}
