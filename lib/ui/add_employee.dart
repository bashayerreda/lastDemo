import 'package:flutter/material.dart';
import 'package:networking/model/Employee.dart';
import 'package:networking/network/api.dart';
import 'package:provider/provider.dart';

class AddAuthor extends StatefulWidget {
  @override
  _AddAuthorState createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  String name;
  String age;
  API api = new API();

  final addAuthor = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: addAuthor,
      appBar: AppBar(
        title: Text('New Employee'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(

                decoration: InputDecoration(
                  labelText: 'Employee Name',
                  hintText: 'Enter Employee name',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Employee age',
                  hintText: 'Enter Employee age',
                ),
                onChanged: (value) {
                  setState(() {
                    age = value;
                  });
                },
              ),
              Consumer<API>(
                  builder: (context, model, child) {
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () {
                        //send data to the internet (aqueduct server)

                        // API.createEmployee(Employee(employee_name: name, employee_age: age))
                        model.createEmployee(name, age)
                            .then((author) {
                          //show snackbar
                          addAuthor.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  'the author with id  has been created')));
                          Navigator.pop(context);
                        });
                      },
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
