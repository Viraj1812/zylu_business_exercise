import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zylu_business_exercise/employee_res_model.dart';

class EmployeeService {
  final CollectionReference _employeeCollection = FirebaseFirestore.instance.collection('employees');

  Future<List<Employee>> getEmployees() async {
    QuerySnapshot snapshot = await _employeeCollection.get();
    return snapshot.docs.map((doc) {
      return Employee(
        id: doc.id,
        name: doc['name'],
        joinDate: doc['joinDate'].toDate(),
        isActive: doc['isActive'],
      );
    }).toList();
  }
}
