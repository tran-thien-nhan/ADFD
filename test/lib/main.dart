import 'package:flutter/material.dart';
import 'package:test/DatabaseHelper.dart';
import 'employee.dart';
import 'create_employee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeList(),
    );
  }
}

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> employeeList = [];
  List<Employee> filterEmployeeList = [];
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateEmployeeList();
  }

  void _updateEmployeeList() async {
    final List<Employee> list = await dbHelper.getEmployeeList();
    setState(() {
      employeeList = list;
      filterEmployeeList =
          list; // Khởi tạo filterEmployeeList bằng danh sách nhân viên
    });
  }

  void _searchEmployees() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filterEmployeeList = employeeList.where((e) {
        return e.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _searchEmployees(); // Gọi hàm tìm kiếm khi giá trị thay đổi
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  filterEmployeeList.length, // Sử dụng filterEmployeeList
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filterEmployeeList[index].name),
                  subtitle: Text(filterEmployeeList[index].gender),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEmployee()),
          ).then((value) {
            _updateEmployeeList();
          });
        },
      ),
    );
  }
}
