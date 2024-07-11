import 'package:mockito/annotations.dart';
import 'package:reqres/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reqres/features/auth/domain/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([AuthRepository, AuthRemoteDataSource],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
