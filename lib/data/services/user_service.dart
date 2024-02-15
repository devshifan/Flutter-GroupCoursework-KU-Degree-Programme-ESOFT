import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/utills/repositories/repository.dart';

class UserService {
  late Repository repository;

  UserService() {
    repository = Repository();
  }

  Future<int?> saveUser(User user) async {
    return await repository.insertData('user', user.userMap());
  }

  Future<List<User>> readUsers() async {
    var usersData = await repository.readData('user');
    return usersData!.map((userData) => User.fromMap(userData)).toList();
  }

  Future<List<ProfileModel>> readProfiles() async {
    var profileData = await repository.readData('profile');
    return profileData!
        .map((profileData) => ProfileModel.fromMap(profileData))
        .toList();
  }

  Future<int?> updateUser(User user) async {
    return await repository.updateData('user', user.userMap());
  }

  Future<int?> deleteUser(int userId) async {
    return await repository.deleteDataById('user', userId);
  }

  Future<User?> getCurrentActiveUser() async {
    var activeUsers =
        await repository.readDataWithWhere('user', where: 'isActiveUser = 1');

    if (activeUsers != null && activeUsers.isNotEmpty) {
      return User.fromMap(activeUsers.first);
    } else {
      return null;
    }
  }

  Future<User?> getUserByUsernameAndPassword(
      String username, String password) async {
    try {
      var users = await repository.readDataWithWhere(
        'user',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );

      if (users != null && users.isNotEmpty) {
        return User.fromMap(users.first);
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting user by username and password: $e");
      return null;
    }
  }

  Future<int?> updateUserProfile(String username, String profileName,
      String bmiCategory, int age, String gender) async {
    print("<------Print------>updateUserProfile start : ");

    var userProfile = await repository.readDataWithWhere('profile',
        where: 'username = ?', whereArgs: [username]);

    if (userProfile != null && userProfile.isNotEmpty) {
      print("<------Print------>updateUserProfile update : ");
      // User exists in profile table, update the existing record
      userProfile.first['bmicategory'] = bmiCategory;
      userProfile.first['age'] = age;
      userProfile.first['gender'] = gender;

      return await repository.updateData('profile', userProfile.first);
    } else {
      print("<------Print------>updateUserProfile username : ${username}");
      // User does not exist in profile table, insert a new record
      var newUserProfile = {
        'username': username,
        'profilename': profileName,
        'age': age,
        'gender': gender,
        'bmicategory': bmiCategory,
      };
      print("<------Print------>updateUserProfile insert new : ");

      return await repository.insertData('profile', newUserProfile);
    }
  }

  Future<int?> updateUserStatus(String username, bool isActive) async {
    try {
      var users = await repository.readDataWithWhere(
        'user',
        where: 'username = ?',
        whereArgs: [username],
      );

      if (users != null && users.isNotEmpty) {
        var user = User.fromMap(users.first);
        user.isActiveUser = isActive;

        return await repository.updateData('user', user.userMap());
      }

      return null; // User not found
    } catch (e) {
      print("<------Print------>Error updating user status: $e");
      return null;
    }
  }
}
