import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:networking/model/Employee.dart';

class API extends ChangeNotifier {
  List<Employee> empList = List();
   Future<Employee> createEmployee(String employee_name , String employee_age ,) async {


    //business logic to send data to server
    final http.Response response = await  http.post('http://dummy.restapiexample.com/api/v1/create',
        headers: <String, String>{

        },
      body: jsonEncode(<String, String>{

        'employee_name': employee_name,
        'employee_age': employee_age,
      }),
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Employee emp = Employee.fromJson(jsonDecode(response.body)["data"]);
      empList.add(emp);

     notifyListeners();
      return emp;
    }
    else {
      print('Error');
      throw Exception("Can't load author");
    }
  }

   Future<List<Employee>> getAllEmployees() async {
    //business logic to send data to server
    final http.Response response = await http.get('http://dummy.restapiexample.com/api/v1/employees');

    if (response.statusCode == 200) {
      //print(response.body);
      //parse json into list of objects


      final parsed = json.decode(response.body);
      final Iterable employeeList = parsed["data"];
      empList = employeeList.map((item) => Employee.fromJson(item)).toList();
      notifyListeners();
      return empList;
    } else {
      print('Error'+response.body);
      throw Exception("Can't load ");
    }
  }
}
