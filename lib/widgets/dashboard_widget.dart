import 'package:flutter/material.dart';
import 'package:todoids/blocs/_blocs.dart';
import 'package:todoids/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    final List<String> _dropdownList = <String>['Session 1', 'Session 2'];
    String dropdownValue = '_dropdownList';

    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 3),
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: todoBox.listenable(),
            builder: (context, Box box, _) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatDashboardWidget(
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
                      _StatDashboardWidget(
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
                      _StatDashboardWidget(
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DropdownCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> dropdownList = [];
    String selectedDropdown = '';

    context.select((AppState state) {
      if (state is Loaded<List<String>>) {
        dropdownList = state.result;
        selectedDropdown = state.data['selected'];
      }
    });

    final drp = dropdownList
        .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(value),
              ),
            ))
        .toList();

    return Container(
      color: Theme.of(context).primaryColor,
      child: DropdownButton<String>(
        value: selectedDropdown,
        onTap: () {
          print('tapped');
        },
        onChanged: (String? newValue) {
          if (newValue != null) {
            context.read<TodoCategoryCubit>().selectDropdown(newValue);
          }
        },
        dropdownColor: Theme.of(context).primaryColor,
        iconSize: 0,
        isExpanded: true,
        elevation: 0,
        style: TextStyle(color: Colors.white),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        items: [...drp, DropdownMenuItem(child: Text('...Add Category'))],
      ),
    );
  }
}

class _StatDashboardWidget extends StatelessWidget {
  final String statDesc;
  final String statTitle;
  final Function()? onTap;

  const _StatDashboardWidget({
    Key? key,
    required this.statDesc,
    required this.statTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Theme(
        // isMaterialAppTheme: true,
        data: Theme.of(context).copyWith(
          textTheme:
              Theme.of(context).textTheme.merge(Typography.whiteCupertino),
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
      ),
    );
  }
}
