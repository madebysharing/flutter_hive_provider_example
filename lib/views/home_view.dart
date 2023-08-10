import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/todo_list_controller.dart';

import '../components/bottom_navigation.dart';

class HomeView extends StatefulWidget {
  static const String id = 'HomeView';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //form dependencies
  bool _toggleFormBool = false;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); //showBottomSheet dependency
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  //animation dependency
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  TodoListController _todoController;

  @override
  void didChangeDependencies() {
    _todoController = Provider.of<TodoListController>(context);
    super.didChangeDependencies();
  }

  // Start of Animated List View //

  AnimatedList _buildAnimatedListView() {
    return AnimatedList(
      key: _animatedListKey,
      initialItemCount: _todoController.todoList.length,
      itemBuilder: (context, index, animation) =>
          _buildListTile(context, index, animation),
    );
  }

  void _addTodo(String item) {
    _todoController.add(item);
    _animatedListKey.currentState.insertItem(
        _todoController.todoList.lastIndexOf(_todoController.todoList.last));
  }

  void _deleteTodo(int index) {
    _animatedListKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) =>
          _buildListTile(context, index, animation),
      duration: const Duration(milliseconds: 250),
    );
    Timer(Duration(milliseconds: 250), () {
      // reduce animation ghosting
      _todoController.del(index);
    });
  }

  void _deleteCompletedTodo(int index) {
    Timer(Duration(milliseconds: 600), () {
      _animatedListKey.currentState.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            _buildListTile(context, index, animation),
        duration: const Duration(milliseconds: 250),
      );
      _todoController.todoList[index]
          .toggleComplete(); // reduce animation ghosting
      Timer(Duration(milliseconds: 100), () {
        // reduce animation ghosting
        _todoController.del(index);
      });
    });
  }

  SizeTransition _buildListTile(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: ListTile(
        leading: Checkbox(
          value: _todoController.todoList[index].isComplete,
          onChanged: (v) {
            setState(() {
              _todoController.todoList[index].toggleComplete();
              _deleteCompletedTodo(index);
            });
          },
        ),
        title: Text(_todoController.todoList[index].toString()),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _deleteTodo(index);
          },
        ),
      ),
    );
  }

  // End of Animated List View //

  // Start of Bottom Form View //

  void _toggleFormView() {
    if (_toggleFormBool) {
      Navigator.pop(context);
    } else {
      this
          ._scaffoldKey
          .currentState
          .showBottomSheet((context) => _buildBottomForm(context));
    }
    _toggleFormBool = !_toggleFormBool;
  }

  RawMaterialButton _openBottomFormButton(context) {
    return RawMaterialButton(
      onPressed: _toggleFormView,
      shape: CircleBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: CircleAvatar(
          radius: 32.0,
          backgroundColor: Colors.white,
          child:
              Icon(Icons.playlist_add, color: Theme.of(context).primaryColor)),
    );
  }

  Form _buildBottomForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 250,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.amber, width: 2.0),
            borderRadius: BorderRadius.circular(8.0)),
        child: ListView(
          children: <Widget>[
            ListTile(
                title: Center(
              child: Text('NEW TODO'),
            )),
            TextFormField(
              controller: _textController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter a Todo';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.edit),
                labelText: 'Enter new Todo',
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text('Add Todo'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _toggleFormView();
                    _addTodo(_textController.text);
                    _textController.text = "";
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // End of Bottom Form View //

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(title: Center(child: Text('Todo List'))),
      body: _buildAnimatedListView(),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: _openBottomFormButton(context),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: BottomNavigation(),
          )
        ],
      ),
    );
  }
}
