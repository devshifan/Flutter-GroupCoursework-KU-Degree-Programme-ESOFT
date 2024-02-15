import 'package:coursework_group/utills/database/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  Future<Database> getConnection() async {
    return await _databaseConnection.getDatabase();
  }

  Future<int?> insertData(String table, Map<String, dynamic> data) async {
    try {
      var connection = await getConnection();
      return await connection.insert(table, data);
    } catch (e) {
      print("Error inserting data into $table: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>?> readDataWithWhere(
    String table, {
    String? where,
    List<Object>? whereArgs,
  }) async {
    try {
      var connection = await getConnection();
      return await connection?.query(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      print("Error reading data from $table with WHERE clause: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>?> readData(String table) async {
    try {
      var connection = await getConnection();
      return await connection?.query(table);
    } catch (e) {
      print("Error reading data from $table: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>?> readDataById(
      String table, int itemId) async {
    try {
      var connection = await getConnection();
      return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
    } catch (e) {
      print("Error reading data from $table by ID: $e");
      rethrow;
    }
  }

  Future<int?> updateData(String table, Map<String, dynamic> data) async {
    try {
      var connection = await getConnection();
      return await connection
          ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
    } catch (e) {
      print("Error updating data in $table: $e");
      rethrow;
    }
  }

  Future<int?> deleteDataById(String table, int itemId) async {
    try {
      var connection = await getConnection();
      return await connection?.rawDelete("DELETE FROM $table WHERE id=$itemId");
    } catch (e) {
      print("Error deleting data from $table by ID: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getBreakfastMealsByCategory(
      String bmiCategory) async {
    try {
      var connection = await getConnection();
      return await connection?.query('meals',
              where: 'bmicategory = ?', whereArgs: [bmiCategory]) ??
          [];
    } catch (e) {
      print("Error fetching breakfast meals by category: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getLunchMealsByCategory(
      String bmiCategory) async {
    try {
      var connection = await getConnection();
      return await connection?.query('meals',
              where: 'bmicategory = ?', whereArgs: [bmiCategory]) ??
          [];
    } catch (e) {
      print("Error fetching lunch meals by category: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getSnacksMealsByCategory(
      String bmiCategory) async {
    try {
      var connection = await getConnection();
      return await connection?.query('meals',
              where: 'bmicategory = ?', whereArgs: [bmiCategory]) ??
          [];
    } catch (e) {
      print("Error fetching snacks meals by category: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDinnerMealsByCategory(
      String bmiCategory) async {
    try {
      var connection = await getConnection();
      return await connection?.query('meals',
              where: 'bmicategory = ?', whereArgs: [bmiCategory]) ??
          [];
    } catch (e) {
      print("Error fetching dinner meals by category: $e");
      return [];
    }
  }

  // Future<List<Map<String, dynamic>>> getWorkoutsByGenderByCategory(
  //     String bmiCategory, String gender) async {
  //   try {
  //     var connection = await getConnection();
  //     final result = await connection?.query('workout',
  //             where: 'bmicategory = ? AND gender = ?',
  //             whereArgs: [bmiCategory, gender]) ??
  //         [];

  //     print(
  //         "Executing query: SELECT * FROM workout WHERE bmicategory = '$bmiCategory' AND gender = '$gender'");
  //     print("Fetched workoutList: $result");

  //     return result;
  //   } catch (e) {
  //     print("Error fetching workouts by gender and category: $e");
  //     return [];
  //   }
  // }
  Future<List<Map<String, dynamic>>> getWorkoutsByCategory(
      String bmiCategory) async {
    try {
      print(
          "Executing query: SELECT * FROM workout WHERE bmicategory = '$bmiCategory'");
      var connection = await getConnection();
      return await connection?.query('workout',
              where: 'bmicategory = ?', whereArgs: [bmiCategory]) ??
          [];
    } catch (e) {
      print("Error fetching workouts by category: $e");
      return [];
    }
  }

  // Future<List<Map<String, dynamic>>> getWorkoutsByGenderByCategory(
  //     String bmiCategory, String gender) async {
  //   try {
  //     print(
  //         "Executing query: SELECT * FROM workout WHERE bmicategory = '$bmiCategory' AND gender = '$gender'");
  //     var connection = await getConnection();
  //     return await connection?.query('workout',
  //             where: 'bmicategory = ? AND gender = ?',
  //             whereArgs: [bmiCategory, gender]) ??
  //         [];
  //   } catch (e) {
  //     print("Error fetching workouts by gender and category: $e");
  //     return [];
  //   }
  // }

  Future<List<Map<String, dynamic>>> getWorkoutsByGenderByCategory(
      String bmiCategory, String gender) async {
    try {
      print(
          "Executing query: SELECT * FROM workout WHERE bmicategory = '$bmiCategory' AND gender = '$gender'");

      var connection = await getConnection();

      // Convert gender to lowercase before executing the query
      return await connection?.query('workout',
              where: 'bmicategory = ? AND LOWER(gender) = ?',
              whereArgs: [bmiCategory, gender.toLowerCase()]) ??
          [];
    } catch (e) {
      print("Error fetching workouts by gender and category: $e");
      return [];
    }
  }

  void printWorkoutTable() async {
    try {
      var connection = await getConnection();
      final result = await connection?.query('workout');
      print("Contents of 'workout' table: $result");
    } catch (e) {
      print("Error printing 'workout' table: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllWorkouts() async {
    try {
      var connection = await getConnection();
      return await connection?.query('workout') ?? [];
    } catch (e) {
      print("Error fetching all workouts: $e");
      return [];
    }
  }

  Future<int?> getLastWorkoutId() async {
    try {
      var connection = await getConnection();
      var result =
          await connection?.query('workout', orderBy: 'id DESC', limit: 1);

      if (result != null && result.isNotEmpty) {
        return result.first['id'] as int?;
      }

      return null;
    } catch (e) {
      print("Error getting last workout ID: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getLastWorkout() async {
    try {
      var connection = await getConnection();
      var result =
          await connection?.query('workout', orderBy: 'id DESC', limit: 1);

      if (result != null && result.isNotEmpty) {
        return result.first;
      }

      return null;
    } catch (e) {
      print("Error getting last workout: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getWorkoutById(int id) async {
    try {
      var connection = await getConnection();
      var result = await connection?.query(
        'workout',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (result != null && result.isNotEmpty) {
        return result.first;
      }

      return null;
    } catch (e) {
      print("Error getting workout by ID: $e");
      return null;
    }
  }
}
