import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _todoForm = GlobalKey<FormState>();

  String todoText;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Text('Hello!'),
              FlatButton(
                child: Text('Delete Todo'),
                onPressed: () {
                  todoBox.clear();
                },
              )
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).appBarTheme.color,
                actions: [
                  FlatButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.white,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.transparent),
                              // border: Border.(borderRadius: BorderRadius.circular(18)),
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
                                          // _todoForm.currentState.value ={}
                                          _todoForm.currentState.validate();

                                          _todoForm.currentState.save();
                                          todoText = val;
                                        },
                                        decoration: const InputDecoration(
                                            hintText: 'Enter Text'),
                                        showCursor: true,
                                      ),
                                      FlatButton(
                                        child: Row(
                                          children: [
                                            Icon(Icons.add),
                                            Text('Tambah')
                                          ],
                                        ),
                                        onPressed: () {
                                          _todoForm.currentState.validate();
                                          // print(_todoForm.currentState.);
                                          // todoBox.put
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
                    },
                    child: Icon(Icons.add),
                  )
                ],
                elevation: 0,
                excludeHeaderSemantics: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.ac_unit,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                // bottom: AppBar(
                //   title: Text('blabla'),
                // ),
                floating: true,
                // snap: true,
                onStretchTrigger: () async {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Hello')));
                },
                // expandedHeight: MediaQuery.of(context).size.height * 0.3,
                // expandedHeight: 50,
                automaticallyImplyLeading: false, title: Text('TodoApp'),
                centerTitle: true,
                iconTheme: Theme.of(context).accentIconTheme,
                // bottom: AppBar(
                //   title: Text('hahahahah'),
                // ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).appBarTheme.color,
                  padding: kMaterialListPadding,
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: todoBox.listenable(),
                          builder: (context, Box box, _) {
                            print(box.values);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                StatDashboardWidget(
                                  statDesc: box.values.length.toString(),
                                  statTitle: 'All Todos',
                                ),
                                StatDashboardWidget(
                                  statDesc: box.values
                                      .where((v) => v['isCompleted'])
                                      .length
                                      .toString(),
                                  statTitle: 'Completed',
                                ),
                                StatDashboardWidget(
                                  statDesc: box.values
                                      .where((v) => !v['isCompleted'])
                                      .length
                                      .toString(),
                                  statTitle: 'Ongoing',
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                  valueListenable: todoBox.listenable(),
                  builder: (context, Box box, widget) {
                    if (box.values.isEmpty) {
                      return Center(
                        child: Text('No Todo'),
                      );
                    }
                    return ListView.builder(
                      itemCount: box.values.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final Map boxAtIndex = box.getAt(index);
                        return GestureDetector(
                          onTap: () {
                            boxAtIndex['isCompleted'] =
                                !boxAtIndex['isCompleted'];
                            box.putAt(
                              index,
                              boxAtIndex,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                            alignment: Alignment.center,
                            child: Text(
                              boxAtIndex['content'],
                              style: boxAtIndex['isCompleted']
                                  ? TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 18,
                                    )
                                  : TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                // Container(
                //   color: Theme.of(context).backgroundColor,
                //   height: 1990,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatDashboardWidget extends StatelessWidget {
  final String statDesc;
  final String statTitle;

  const StatDashboardWidget({Key key, this.statDesc, this.statTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.merge(Typography.whiteCupertino),
      ),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Text(
                statDesc,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                statTitle,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          );
        },
      ),
    );
  }
}
