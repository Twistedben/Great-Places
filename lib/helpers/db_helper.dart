import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// WQe use static methods so we don't have to instantiate this class, and it acts as a wrapper
class DBHelper {
  // Method for opening the DB. Database is a type provided by sqflite package
  static Future<sql.Database> dataBase() async {
    final dbPath =
        await sql.getDatabasesPath(); // path where you store database
    // Opens existing database or creates a new one. HAs to be path that includes DB name, hence why we use path package, join where we call the DB and the name.
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        // on create is a function that will execute when it tries to open DB and then creates it and executes that. Version specifies which DB, but only using one, you can always say version: 1
        onCreate: (db, version) {
      // Execute runs a sql query against DB, returns future to say it's done. Go here for sql commands: https://pub.dev/packages/sqflite#raw-sql-queries
      return db.execute(
          // Creates the user_places table with a primary key ID and title and image fields.
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  // A future helper that can be used without instatiation to insert into a provided table and the data to insert. Used in great_places.dart to insert data
  static Future<void> insert(String table, Map<String, Object> data) async {
    // Here we insert the data from great_places.dart addPlace function called from add_place_screen, providing the arguments we get from this function from there, the table name and the mapped data. ConflictAlgorithm will overwrite existing data with new data.
    final db = await DBHelper.dataBase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Fetch data from DB. We return a List<Map>String, dynamic>>> inside the query command from the table. Used in great_places.dart to get the data
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.dataBase();
    // Retreive data as a Future Map
    return db.query(table);
  }
}
