class CryptoResponseModel<T> {
  late Status status;
  late T data;
  late String message;

  CryptoResponseModel.loading(this.message) : status = Status.LOADING;
  CryptoResponseModel.completed(this.data) : status = Status.COMPLETED;
  CryptoResponseModel.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status { LOADING, COMPLETED, ERROR }
