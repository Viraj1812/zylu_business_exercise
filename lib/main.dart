import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zylu_business_exercise/employee_list_widget.dart';
import 'package:zylu_business_exercise/employee_res_model.dart';
import 'package:zylu_business_exercise/employee_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Employee App',
      home: EmployeeScreen(),
    );
  }
}

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  EmployeeScreenState createState() => EmployeeScreenState();
}

class EmployeeScreenState extends State<EmployeeScreen> {
  final EmployeeService _employeeService = EmployeeService();
  late Future<List<Employee>> _employeeFuture;

  @override
  void initState() {
    super.initState();
    _employeeFuture = _employeeService.getEmployees();
  }

  Future<void> _refreshEmployees() async {
    setState(() {
      _employeeFuture = _employeeService.getEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshEmployees,
          ),
        ],
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List<Employee>? employees = snapshot.data;
          return EmployeeListWidget(employees: employees ?? []);
        },
      ),
    );
  }
}
