import 'package:dio/dio.dart';
import 'package:teeeemj_test/data/models/users_list_model.dart';

class GithubRepository {
  final Dio dio;

  GithubRepository({required this.dio});

  Future<List<UsersListModel>> getUsers(
      {int since = 0, int perPage = 10}) async {
    final Response response = await dio
        .get('https://api.github.com/users?since=$since&per_page=$perPage');
    return response.data
        .map<UsersListModel>((json) => UsersListModel.fromJson(json))
        .toList();
  }
}
