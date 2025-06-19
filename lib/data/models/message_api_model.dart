class MessageApiModel<T> {
  final bool success;
  final String message;
  final T? data;

  MessageApiModel({required this.success, required this.message, this.data});

  factory MessageApiModel.success({required String message, T? data}) {
    return MessageApiModel(success: true, message: message, data: data);
  }

  factory MessageApiModel.error({required String message}) {
    return MessageApiModel(success: false, message: message, data: null as T);
  }
  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }
}
