import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Database? _database;

  Future<Database> getDatabase() async {
    try {
      if (_database != null && _database!.isOpen) {
        return _database!;
      } else {
        _database = await setDatabase();
        return _database!;
      }
    } catch (e) {
      print("Error getting database instance: $e");
      rethrow; // Use rethrow here
    }
  }

  Future<Database> setDatabase() async {
    try {
      var directory = await getApplicationDocumentsDirectory();
      var path = join(directory.path, 'db_crud.db');
      _database =
          await openDatabase(path, version: 1, onCreate: _createDatabase);
      return _database!;
    } catch (e) {
      print("Error creating database: $e");
      rethrow; // Use rethrow here
    }
  }

  Future<void> _createDatabase(Database database, int version) async {
    try {
      // Create user table
      String userTableSql = '''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY,
          username TEXT,
          email TEXT,
          password TEXT,
          isActiveUser INTEGER
        );
      ''';
      await database.execute(userTableSql);

      // Create profile table
      String profileTableSql = '''
        CREATE TABLE profile (
          id INTEGER PRIMARY KEY,
          username TEXT,
          profilename TEXT,
          age INTEGER,
          gender TEXT,
          bmicategory TEXT
        );
      ''';
      await database.execute(profileTableSql);

      // Create meals table
      String mealsTableSql = '''
        CREATE TABLE meals (
          id INTEGER PRIMARY KEY,
          breakfast TEXT,
          lunch TEXT,
          snacks TEXT,
          dinner TEXT,
          bmicategory TEXT
        );
      ''';
      await database.execute(mealsTableSql);

      // Insert default values into meals table
      _insertDefaultMeals(database);

      // Create workout table
      String workoutTableSql = '''
        CREATE TABLE workout (
          id INTEGER PRIMARY KEY,
          lowerbody TEXT,
          upperbody TEXT,
          gender TEXT,
          bmicategory TEXT
        );
      ''';
      await database.execute(workoutTableSql);

      // Insert default values into workout table
      _insertDefaultWorkout(database);

      print("Tables created successfully");
    } catch (e) {
      print("Error creating database tables: $e");
      rethrow; // Use rethrow here
    }
  }

  void _insertDefaultMeals(Database database) async {
    try {
      // Value set 1
      await database.rawInsert(
        'INSERT INTO meals (breakfast, lunch, snacks, dinner, bmicategory) VALUES (?, ?, ?, ?, ?)',
        [
          "Banana smoothie made with whole milk,Yogurt with honey and a handful of nuts,Grain toast with scrambled eggs",
          "Grilled chicken or chickpea, Quinoa salad with roasted vegetables,Rice & Curry",
          "Protein shake made with whole milk, cottage cheese and sliced avocado, sliced fruits",
          "Baked salmon , chicken with mixed vegetables, brown rice",
          "underweight"
        ],
      );

      // Value set 2
      await database.rawInsert(
        'INSERT INTO meals (breakfast, lunch, snacks, dinner, bmicategory) VALUES (?, ?, ?, ?, ?)',
        [
          "Scrambled eggs (2-3 eggs), Whole grain toast or quinoa, Greek yogurt with berries,Green tea or black coffee",
          "Grilled chicken breast or tofu/tempeh, Quinoa or brown rice, Steamed vegetables (broccoli, carrots)",
          "cheese with pineapple chunks, Apple slices with almond butter, Rice cakes with turkey slices",
          "Baked salmon or lean beef steak, Sweet potato or quinoa, Steamed asparagus or green beans",
          "normalWeight"
        ],
      );

      // Value set 3
      await database.rawInsert(
        'INSERT INTO meals (breakfast, lunch, snacks, dinner, bmicategory) VALUES (?, ?, ?, ?, ?)',
        [
          "Green tea or black coffee, Greek yogurt with berries, Whole grain toast or quinoa",
          "Quinoa or brown rice, Steamed vegetables, Mixed green salad",
          "Apple slices with almond butter, Rice cakes with turkey slices, dates",
          "Sweet potato or quinoa, Sautéed kale or spinach with garlic, green beans",
          "overweight"
        ],
      );

      // Value set 4
      await database.rawInsert(
        'INSERT INTO meals (breakfast, lunch, snacks, dinner, bmicategory) VALUES (?, ?, ?, ?, ?)',
        [
          "Hard-boiled egg, Green tea or black coffee",
          "Sliced cucumber and carrot sticks, Low-fat Greek yogurt, Mixed green salad",
          "Apple slices with almond butter, Rice cakes with turkey slices, dates",
          "Handful of almonds or walnuts, Sautéed kale or spinach with garlic, green beans",
          "obesity"
        ],
      );

      print("Default meals inserted successfully");
    } catch (e) {
      print("Error inserting default meals: $e");
      rethrow;
    }
  }

  void _insertDefaultWorkout(Database database) async {
    try {
      // Value set 1-f
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 8-12 reps),Romanian Deadlifts(3 sets of 8-12 reps),Leg Press(3 sets of 8-12 reps),Calf Raises(3 sets of 8-12 reps)",
          "Bench Press(3 sets of 8-12 reps),Bent-over Rows(3 sets of 8-12 reps),Shoulder Press(3 sets of 8-12 reps),Pull-ups(3 sets of 8-12 reps),Bicep Curls(3 sets of 8-12 reps),Tricep Dips(3 sets of 8-12 reps)",
          "Female",
          "underweight"
        ],
      );

      // Value set 2-f
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 8-12 reps),Romanian Deadlifts(3 sets of 8-12 reps),Leg Press(3 sets of 8-12 reps),Calf Raises(3 sets of 8-12 reps)",
          "Bench Press(3 sets of 8-12 reps),Bent-over Rows(3 sets of 8-12 reps),Shoulder Press(3 sets of 8-12 reps),Pull-ups(3 sets of 8-12 reps),Bicep Curls(3 sets of 8-12 reps),Tricep Dips(3 sets of 8-12 reps)",
          "Female",
          "normalWeight"
        ],
      );

      // Value set 3-f
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 8-12 reps),Romanian Deadlifts(3 sets of 8-12 reps),Leg Press(3 sets of 8-12 reps),Calf Raises(3 sets of 8-12 reps)",
          "Bench Press(3 sets of 8-12 reps),Bent-over Rows(3 sets of 8-12 reps),Shoulder Press(3 sets of 8-12 reps),Pull-ups(3 sets of 8-12 reps),Bicep Curls(3 sets of 8-12 reps),Tricep Dips(3 sets of 8-12 reps)",
          "Female",
          "overweight"
        ],
      );

      // Value set 4-f
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 8-12 reps),Romanian Deadlifts(3 sets of 8-12 reps),Leg Press(3 sets of 8-12 reps),Calf Raises(3 sets of 8-12 reps)",
          "Bench Press(3 sets of 8-12 reps),Bent-over Rows(3 sets of 8-12 reps),Shoulder Press(3 sets of 8-12 reps),Pull-ups(3 sets of 8-12 reps),Bicep Curls(3 sets of 8-12 reps),Tricep Dips(3 sets of 8-12 reps)",
          "Female",
          "obesity"
        ],
      );
      // Value set 1-m
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 12-15 reps),Romanian Deadlifts(3 sets of 12-15 reps),Leg Press(3 sets of 12-15 reps),Calf Raises(3 sets of 12-15 reps)",
          "Bench Press(3 sets of 12-15 reps),Bent-over Rows(3 sets of 12-15 reps),Shoulder Press(3 sets of 12-15 reps),Pull-ups(3 sets of 12-15 reps),Bicep Curls(3 sets of 12-15 reps),Tricep Dips(3 sets of 12-15 reps)",
          "Male",
          "underweight"
        ],
      );

      // Value set 2-m
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 12-15 reps),Romanian Deadlifts(3 sets of 12-15 reps),Leg Press(3 sets of 12-15 reps),Calf Raises(3 sets of 12-15 reps)",
          "Bench Press(3 sets of 12-15 reps),Bent-over Rows(3 sets of 12-15 reps),Shoulder Press(3 sets of 12-15 reps),Pull-ups(3 sets of 12-15 reps),Bicep Curls(3 sets of 12-15 reps),Tricep Dips(3 sets of 12-15 reps)",
          "Male",
          "normalWeight"
        ],
      );

      // Value set 3-m
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 12-15 reps),Romanian Deadlifts(3 sets of 12-15 reps),Leg Press(3 sets of 12-15 reps),Calf Raises(3 sets of 12-15 reps)",
          "Bench Press(3 sets of 12-15 reps),Bent-over Rows(3 sets of 12-15 reps),Shoulder Press(3 sets of 12-15 reps),Pull-ups(3 sets of 12-15 reps),Bicep Curls(3 sets of 12-15 reps),Tricep Dips(3 sets of 12-15 reps)",
          "Male",
          "overweight"
        ],
      );

      // Value set 4-m
      await database.rawInsert(
        'INSERT INTO workout (lowerbody, upperbody, gender, bmicategory) VALUES (?, ?, ?, ?)',
        [
          "Squats(3 sets of 12-15 reps),Romanian Deadlifts(3 sets of 12-15 reps),Leg Press(3 sets of 12-15 reps),Calf Raises(3 sets of 12-15 reps)",
          "Bench Press(3 sets of 12-15 reps),Bent-over Rows(3 sets of 12-15 reps),Shoulder Press(3 sets of 12-15 reps),Pull-ups(3 sets of 12-15 reps),Bicep Curls(3 sets of 12-15 reps),Tricep Dips(3 sets of 12-15 reps)",
          "Male",
          "obesity"
        ],
      );
      print("Default workout inserted successfully");
    } catch (e) {
      print("Error inserting default workout: $e");
      rethrow; // Use rethrow here
    }
  }
}
