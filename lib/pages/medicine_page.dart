import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  List<Map<String, dynamic>> medicines = [];

  @override
  void initState() {
    super.initState();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    final settings = ConnectionSettings(
      host: 'your_mysql_host', // 실제 MySQL 호스트로 변경
      port: 3306,
      user: 'your_mysql_user', // 실제 MySQL 사용자로 변경
      password: 'your_mysql_password', // 실제 MySQL 비밀번호로 변경
      db: 'wealthy',
    );

    try {
      final conn = await MySqlConnection.connect(settings);
      var results = await conn.query('SELECT * FROM medical_data');

      setState(() {
        medicines = results
            .map((row) => {
                  'product_name': row['product_name'],
                  'company_name': row['company_name'],
                  'product_image': row['product_image'],
                  'drug_form': row['drug_form'],
                  'color_front': row['color_front'],
                  'color_back': row['color_back'],
                  'mark_front': row['mark_front'],
                  'mark_back': row['mark_back'],
                  'category_name': row['category_name'],
                  'prescription_type': row['prescription_type'],
                })
            .toList();
      });

      await conn.close();
    } catch (e) {
      print('Error: $e');
    }
  }

  void addMedicine() {
    // TODO: Implement the functionality to add a new medicine
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의약품 목록'),
      ),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicines[index];
          return Card(
            child: ListTile(
              leading: medicine['product_image'] != null
                  ? Image.network(medicine['product_image'])
                  : Icon(Icons.medication),
              title: Text(medicine['product_name']),
              subtitle: Text(medicine['company_name']),
              onTap: () {
                // TODO: Show detailed information about the medicine
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addMedicine,
        child: Icon(Icons.add),
      ),
    );
  }
}
