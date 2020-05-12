
class TodoItemModel{
  String _item;
  bool _isComplete = false;

  // constructors
  TodoItemModel(this._item);

  // getters
  bool get isComplete => _isComplete;

  @override
  String toString() {
    return _item;
  }

  // setters
  void setItem(String item) {
    _item = item;
  }

  void toggleComplete() {
    _isComplete = !_isComplete;
  }

}