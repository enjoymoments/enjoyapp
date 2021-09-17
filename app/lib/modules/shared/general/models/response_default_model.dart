class _ResponseDefaultModelBase<T> {
  final bool? isSuccess;
  final String? message;
  final T? data;

  _ResponseDefaultModelBase({
    this.isSuccess,
    this.message,
    this.data,
  });
}

class ResponseDefaultModel<T> extends _ResponseDefaultModelBase<T> {
  ResponseDefaultModel({
    bool? isSuccess,
    final String? message,
    final T? data,
  }) : super(
          isSuccess: isSuccess,
          message: message,
          data: data,
        );

  factory ResponseDefaultModel.fromJson(Map<String, dynamic> json) {
    return ResponseDefaultModel(
      isSuccess: json['isSuccess'],
      message: json['message'],
      data: json['data'],
    );
  }
}
