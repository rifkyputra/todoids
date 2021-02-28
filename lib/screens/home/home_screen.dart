import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/blocs/app_event.dart';
import 'package:flutter_todo_app/blocs/app_state.dart';
import 'package:flutter_todo_app/blocs/list_todo/list_todo_bloc.dart';
import 'package:flutter_todo_app/blocs/theme/theme_bloc.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/todo_item.dart';
import 'package:flutter_todo_app/screens/about_screen.dart';
import 'package:flutter_todo_app/screens/settings_screen.dart';
import 'package:flutter_todo_app/widgets/stat_dashboard_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _todoForm;

  GlobalKey<ScaffoldState> _scaffoldKey;

  String todoText;

  @override
  initState() {
    _todoForm = GlobalKey<FormState>();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  dispose() {
    _todoForm.currentState.dispose();
    _scaffoldKey.currentState.dispose();
    super.dispose();
  }

  Future _createTodo() {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).dialogBackgroundColor,
            border:
                Border.all(style: BorderStyle.solid, color: Colors.transparent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Text('Tulis Todo Anda'),
              ),
              Form(
                key: _todoForm,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  _todoForm.currentState.save();
                },
                child: Column(
                  children: [
                    TextFormField(
                      key: Key('text1'),
                      onChanged: (val) {
                        _todoForm.currentState.validate();

                        _todoForm.currentState.save();
                        todoText = val;
                      },
                      decoration: const InputDecoration(hintText: 'Enter Text'),
                      showCursor: true,
                    ),
                    FlatButton(
                      child: Row(
                        children: [Icon(Icons.add), Text('Tambah')],
                      ),
                      onPressed: () {
                        _todoForm.currentState.validate();

                        todoBox.add({
                          'content': todoText,
                          'isCompleted': false,
                        });

                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _useDrawer() {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).push(SettingsScreen.route());
            },
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              Icon icon = Icon(Icons.nightlight_round);
              Text text = Text('Dark Mode');

              if (Theme.of(context).brightness == Brightness.dark) {
                icon = Icon(Icons.ac_unit);
                text = Text('Bright Mode');
              }

              return ListTile(
                leading: icon,
                title: text,
                onTap: () {
                  context.read<ThemeCubit>().toggleDarkTheme();
                  // Theme.of(context).
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).push(AboutScreen.route());
              // Theme.of(context).
            },
          ),
        ],
      ),
    );
  }

  Widget _useAppbar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).appBarTheme.color,
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          color: Colors.white,
          onPressed: () async => await _createTodo(),
        )
      ],
      elevation: 0,
      excludeHeaderSemantics: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
        ),
        color: Colors.white,
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      floating: true,
      onStretchTrigger: () async {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Hello'),
          ),
        );
      },
      automaticallyImplyLeading: false,
      title: Text('Todo App'),
      centerTitle: true,
      iconTheme: Theme.of(context).accentIconTheme,
    );
  }

  Widget _useDashboard() {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).appBarTheme.color,
        padding: kMaterialListPadding,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, Box box, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatDashboardWidget(
                      statDesc: box.values.length.toString(),
                      statTitle: 'All Todos',
                      onTap: () {
                        context.read<ListTodoBloc>().add(
                              Get<ListTodoTypes>(
                                request: ListTodoTypes.All,
                              ),
                            );
                      },
                    ),
                    StatDashboardWidget(
                      statDesc: box.values
                          .where((v) => v['isCompleted'])
                          .length
                          .toString(),
                      statTitle: 'Completed',
                      onTap: () {
                        context.read<ListTodoBloc>().add(
                              Get<ListTodoTypes>(
                                request: ListTodoTypes.Completed,
                              ),
                            );
                      },
                    ),
                    StatDashboardWidget(
                      statDesc: box.values
                          .where((v) => !v['isCompleted'])
                          .length
                          .toString(),
                      statTitle: 'Ongoing',
                      onTap: () {
                        context.read<ListTodoBloc>().add(
                              Get<ListTodoTypes>(
                                request: ListTodoTypes.Ongoing,
                              ),
                            );
                      },
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _useDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              _useAppbar(),
              _useDashboard(),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<ListTodoBloc, AppState>(
                  builder: (context, state) {
                    if (state is Loaded<List<TodoItem>>) {
                      if (state.result.isEmpty) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(child: Text('No Todo')),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.result.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // final Map boxAtIndex = todoBox.getAt(index);
                          TodoItem item = state.result[index];
                          return GestureDetector(
                            onTap: () {
                              // todoBox.get();

                              item = item.copyWith(completed: !item.completed);
                              todoBox.putAt(
                                item.id,
                                item.toMap(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 10,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '   ${state.result[index].name}   ',
                                style: item.completed
                                    ? TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 18,
                                        color: Colors.grey,
                                      )
                                    : TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
