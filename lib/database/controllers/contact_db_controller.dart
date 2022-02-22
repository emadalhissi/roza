// import 'package:Rehrati/database/db_controller.dart';
// import 'package:Rehrati/database/db_operations.dart';
// import 'package:Rehrati/models/contact.dart';
// import 'package:sqflite/sqflite.dart';
//
// class ContactDbController implements DbOperations<Contact> {
//   final Database _database = DbController().getDatabase;
//
//   @override
//   Future<int> create(Contact object) async {
//     int newRow = await _database.insert('contacts', object.toMap());
//     return newRow;
//   }
//
//   @override
//   Future<bool> delete(int id) async {
//     int numberOfDeletedRows = await _database.delete(
//       'contacts',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     return numberOfDeletedRows > 0;
//   }
//
//   @override
//   // Read All
//   Future<List<Contact>> read() async {
//     List<Map<String, dynamic>> mapRows = await _database.query('contacts');
//     return mapRows.map((mapRow) => Contact.fromMap(mapRow)).toList();
//   }
//
//   @override
//   // Read item based on ID
//   Future<Contact?> show(int id) async {
//     List<Map<String, dynamic>> row = await _database.query(
//       'contacts',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     return row.isNotEmpty ? Contact.fromMap(row.first) : null;
//   }
//
//   @override
//   Future<bool> update(Contact object) async {
//     int numberOfUpdatedRows = await _database.update(
//       'contacts',
//       object.toMap(),
//       where: 'id = ?',
//       whereArgs: [object.id],
//     );
//     return numberOfUpdatedRows > 0;
//   }
// }
