import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:reqres/features/profile/data/datasources/user_remote_data_source.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/repositories/user_repository.dart';
import 'package:reqres/features/profile/presentation/profile_screen.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/utils/report_service.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<String, User>> createUser(String token, String name,
      String birthday, int height, int weight, List<String> interests) async {
    // TODO: implement createUser
    try {
      final result = await remoteDataSource.createUser(
          token, name, birthday, height, weight, interests);
      return Right(result);
    } on SocketException catch (e) {
      log(e.message);
      return Left(e.message);
    } catch (e) {
      String location = 'createUser';

      final reportService = sl<ReportService>();
      await reportService.reportError(e.toString(), location);

      log('$location -> ${e.toString()}');
      return const Left('');
    }
  }

  @override
  Future<Either<String, User>> getUser(String token) async {
    try {
      final result = await remoteDataSource.getUser(token);
      return Right(result);
    } on SocketException catch (e) {
      log(e.message);
      return Left(e.message);
    } catch (e) {
      String location = 'getUser';

      final reportService = sl<ReportService>();
      await reportService.reportError(e.toString(), location);

      log('$location -> ${e.toString()}');
      return const Left('');
    }
  }

  @override
  Future<Either<String, User>> updateUser(String token, String name,
      String birthday, int height, int weight, List<String> interests) async {
    // TODO: implement updateUser
    try {
      final result = await remoteDataSource.updateUser(
          token, name, birthday, height, weight, interests);
      return Right(result);
    } on SocketException catch (e) {
      log(e.message);
      return Left(e.message);
    } catch (e) {
      String location = 'updateUser';

      final reportService = sl<ReportService>();
      await reportService.reportError(e.toString(), location);

      log('$location -> ${e.toString()}');
      return const Left('');
    }
  }
}
