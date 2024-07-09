import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../authorisation/data layer/models/user_model.dart';

class DateRemoteDataSource {
  final http.Client client;

  DateRemoteDataSource({required this.client});

  Future<List<UserModel>> getRecommendations() async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/recommendations/get"),
      headers: {
        //'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var recommendedUsersJson = jsonData["recommendedUsers"] as List<dynamic>;
      return recommendedUsersJson
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  Future<List<UserModel>> getUserMatches() async {
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/date/matches"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
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
    print(response.body);
    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
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
    } else {
      throw ServerException();
    }
  }

  Future<dynamic> get token async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}
