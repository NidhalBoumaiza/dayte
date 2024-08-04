import 'dart:convert';

import 'package:client/features/dates/data%20layer/models/match_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../authorisation/data layer/models/user_model.dart';

class DateRemoteDataSource {
  final http.Client client;

  DateRemoteDataSource({required this.client});

  Future<List<UserModel>> getRecommendations(bool isShuffle) async {
    print(isShuffle);
    final token = await this.token;
    dynamic response;
    if (isShuffle) {
      response = await client.get(
        Uri.parse("${dotenv.env['URL']}/recommendations/shuffle"),
        headers: {
          //'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } else {
      response = await client.get(
        Uri.parse("${dotenv.env['URL']}/recommendations/get"),
        headers: {
          //'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    }

    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var recommendedUsersJson = jsonData["recommendedUsers"] as List<dynamic>;
      return recommendedUsersJson
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else if (response.statusCode == 400 && isShuffle == true) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ShuffleFailure.message = errorMessage;
      throw ShuffleException();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else if (response.statusCode == 400 && isShuffle != true) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 405) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      EndOfPlanFailure.message = errorMessage;
      throw const EndOfPlanException();
    } else {
      throw ServerException();
    }
  }

  Future<List<MatchModel>> getUserMatches() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/date/matches"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<dynamic> jsonList = jsonData['dates'];
      return jsonList
          .map((json) => MatchModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 405) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      EndOfPlanFailure.message = errorMessage;
      throw const EndOfPlanException();
    } else {
      throw ServerException();
    }
  }

  Future<Unit> likeRecommendation(String userId) async {
    final token = await this.token;
    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/date/like"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'likedUserId': userId}),
    );

    if (response.statusCode == 206) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['date']['matched'] == true) {
        MatchedUserFailure.id = responseBody['date']['_id'] as String;
        MatchedUserFailure.likingUser =
            UserModel.fromJson(responseBody['date']['likingUser']);
        MatchedUserFailure.likedUser =
            UserModel.fromJson(responseBody['date']['likedUser']);
        throw MatchedException();
      }
      return unit;
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 405) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      EndOfPlanFailure.message = errorMessage;
      throw const EndOfPlanException();
    } else {
      throw ServerException();
    }
  }

  Future<Unit> proposeTimeAndDate(String userId, DateTime dateTime) async {
    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/date/setProposedDate"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'proposedDateTime': dateTime.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 405) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      EndOfPlanFailure.message = errorMessage;
      throw const EndOfPlanException();
    } else {
      throw ServerException();
    }
  }

  Future<Unit> shuffleRecommendations() async {
    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/date/shuffle"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 405) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      EndOfPlanFailure.message = errorMessage;
      throw const EndOfPlanException();
    } else {
      throw ServerException();
    }
  }

  Future<Unit> cancelDate(String dateId) async {
    final token = await this.token;
    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/date/cancelDate"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'id': dateId}),
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 405) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      EndOfPlanFailure.message = errorMessage;
      throw const EndOfPlanException();
    } else {
      throw ServerException();
    }
  }

  // Future<Unit> handleResponse(http.Response response) async {
  //   final responseBody = jsonDecode(response.body);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     if (responseBody.containsKey('token')) {
  //       final token = responseBody['token'];
  //       saveToken(token);
  //     }
  //     return Future.value(unit);
  //   } else if (response.statusCode == 400) {
  //     final errorMessage = responseBody['message'] as String;
  //
  //     ServerMessageFailure.message = errorMessage;
  //     throw ServerMessageException();
  //   } else if (response.statusCode == 410) {
  //     final errorMessage = responseBody['message'] as String;
  //
  //     UnauthorizedFailure.message = errorMessage;
  //     throw const UnauthorizedException();
  //   } else {
  //     throw ServerException();
  //   }
  // }

  Future<dynamic> get token async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}
