import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [Text('Hello!')],
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
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30),
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
                                TextFormField(
                                  showCursor: true,
                                )
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StatDashboardWidget(
                            statDesc: '0',
                            statTitle: 'All Todos',
                          ),
                          StatDashboardWidget(
                            statDesc: '0',
                            statTitle: 'Completed',
                          ),
                          StatDashboardWidget(
                            statDesc: '0',
                            statTitle: 'Ongoing',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  height: 1990,
                ),
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
