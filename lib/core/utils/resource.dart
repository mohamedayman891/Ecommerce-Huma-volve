class Resource<T> {
  String errorMessage = '';
  T? data;
  Status status = Status.initial;

  bool get isLoading => status == Status.loading;

  bool get isError => status == Status.error;

  bool get isSuccess => status == Status.success;

  Resource.initial();

  Resource.loading({this.errorMessage = '', this.data}) {
    status = Status.loading;
  }

  Resource.success({this.errorMessage = '', this.data}) {
    status = Status.success;
  }

  Resource.error({this.errorMessage = '', this.data}) {
    status = Status.error;
  }
}

enum Status { initial, loading, error, success }
