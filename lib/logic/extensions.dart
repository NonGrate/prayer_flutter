extension NullOrEmpty on Object? {
  bool isNullOrEmpty() => this == null || this == '';
}