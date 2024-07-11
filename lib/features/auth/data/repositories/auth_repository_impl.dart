import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:reqres/core/exception/exception.dart';
import 'package:reqres/core/failure/failure.dart';
import 'package:reqres/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reqres/features/auth/domain/repositories/auth_repository.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/utils/report_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<String, String>> login(String email, String username,
      String password, String? deviceToken) async {
    try {
      final result =
          await remoteDataSource.login(email, username, password, deviceToken);
      return Right(result);
    } on SocketException catch (e) {
      log(e.message);
      return Left(e.message);
    } catch (e) {
      String location = 'login';

      final reportService = sl<ReportService>();
      await reportService.reportError(e.toString(), location);

      log('$location -> ${e.toString()}');
      return const Left('');
    }
  }

  @override
  Future<Either<String, String>> register(
      String email, String username, String password) async {
    // TODO: implement register
    try {
      final result = await remoteDataSource.register(email, username, password);
      return Right(result);
    } on SocketException catch (e) {
      log(e.message);
      return Left(e.message);
    } catch (e) {
      String location = 'register';

      final reportService = sl<ReportService>();
      await reportService.reportError(e.toString(), location);

      log('$location -> ${e.toString()}');
      return const Left('');
    }
  }
}
