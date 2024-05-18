import 'package:flutter/material.dart';
import 'package:zylu_business_exercise/employee_res_model.dart';
import 'package:intl/intl.dart';

class EmployeeListWidget extends StatelessWidget {
  final List<Employee> employees;

  const EmployeeListWidget({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        Employee employee = employees[index];
        Color backgroundColor = employee.isActive && DateTime.now().difference(employee.joinDate).inDays >= 1825
            ? Colors.green
            : Colors.transparent;

        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Join Date: ${DateFormat.yMMMd().format(employee.joinDate)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Active: ${employee.isActive ? "Yes" : "No"}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
