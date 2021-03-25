import 'package:flutter/material.dart';
import 'package:networking/model/Employee.dart';
import 'package:networking/network/api.dart';
import 'package:provider/provider.dart';


import 'add_employee.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  API api = new API();
  Future<List<Employee>> authors;
  @override
  void initState() {
    super.initState();
    setState(() {
      authors = api.getAllEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking lesson 2'),
      ),
      body: Consumer<API>(
        builder: (context, model, child) {

          return ListView.builder(
              itemCount: model.empList.length,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    title: Text(model.empList[i].employee_name),
                    subtitle: Row(
                      children: <Widget>[

                        SizedBox(
                          width: 100,
                        ),
                        Text('${model.empList[i].employee_age}'),
                      ],
                    ),
                  ),
                );
              });



        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAuthor(),
            ),
          );
          setState(() {
            authors = api.getAllEmployees();
          });
        },
      ),
    );
  }
}
