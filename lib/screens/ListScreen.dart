import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/controllers/ListController.dart';
import 'package:todomobx/controllers/LoginController.dart';
import 'package:todomobx/controllers/TasksController.dart';
import 'package:todomobx/widgets/StandardIconButton.dart';
import 'package:todomobx/widgets/StandardTextField.dart';

import 'LoginScreen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ListController _listController = ListController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tasks',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {
                        Provider.of<LoginController>(context, listen: false).logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Observer(builder: (_) {
                          return CustomTextField(
                              controller: _textEditingController,
                              hint: 'Task',
                              onChanged: _listController.setTaskTitle,
                              suffix: _listController.isFormValid
                                  ? CustomIconButton(
                                      radius: 32,
                                      iconData: Icons.add,
                                      onTap: () {
                                        _textEditingController.clear();
                                        _listController.addTask();
                                      },
                                    )
                                  : null);
                        }),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(child: Observer(
                          builder: (_) {
                            return ListView.separated(
                              itemCount: _listController.tasksList.length,
                              itemBuilder: (_, index) {
                                final task = _listController.tasksList[index];
                                return Observer(builder: (_) {
                                  return ListTile(
                                    title: Text(task.title,
                                        style: TextStyle(
                                            color: task.done
                                                ? Colors.grey
                                                : Colors.black,
                                            decoration: task.done
                                                ? TextDecoration.lineThrough
                                                : null)),
                                    onTap: task.toggleDone,
                                  );
                                });
                              },
                              separatorBuilder: (_, __) {
                                return Divider(
                                  thickness: 1,
                                );
                              },
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
