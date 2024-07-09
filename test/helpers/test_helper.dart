import 'package:mockito/annotations.dart';
import 'package:reqres/features/home/data/datasources/home_remote_data_source.dart';
import 'package:reqres/features/home/domain/repositories/home_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([HomeRepository, HomeRemoteDataSource],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
