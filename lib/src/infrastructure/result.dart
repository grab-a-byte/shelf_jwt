class Result<T> {
  T? data;
  bool get isSuccessfull => data == null;
  String? errorMessage;

  Result._({this.data, this.errorMessage});

  factory Result.success(T data) => Result._(data: data);

  factory Result.faliure(String errorMessage) =>
      Result._(errorMessage: errorMessage);
}
