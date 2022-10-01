class Result<T> {
  T? data;
  bool get isSuccessfull => data != null;
  bool get isError => !isSuccessfull;

  String? errorMessage;

  Result._({this.data, this.errorMessage});

  factory Result.success(T data) => Result._(data: data);

  factory Result.faliure(String errorMessage) =>
      Result._(errorMessage: errorMessage);
}
