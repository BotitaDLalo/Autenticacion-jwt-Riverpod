import 'package:teslo_app_latest/config/config.dart';
import 'package:teslo_app_latest/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_app_latest/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:teslo_app_latest/features/auth/infraestructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
//? Es posible colocarlo en config o algo asi
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final res = await dio.get('/auth/check-status',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = UserMapper.userJsonToEntity(res.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw CustomError(message: 'Token incorrecto', errorCode: 1);
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final res = await dio
          .post('/auth/login', data: {'email': email, 'password': password});

      final user = UserMapper.userJsonToEntity(res.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredentials();
      if (e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      throw CustomError(message: 'Ocurrio un error', errorCode: 1);
    } catch (e) {
      throw CustomError(message: 'Ocurrio un error', errorCode: 1);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
