import 'dart:convert';

import 'package:client/core/error/exceptions.dart';
import 'package:client/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain layer/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Unit> register(
      String phoneNumber, String password, String confirmPassword);

  Future<Unit> sendVerificationCode();

  Future<Unit> verifyPhoneNumber(String code);

  Future<Unit> finishProfile(UserModel userModel);

  Future<UserModel> login(String phoneNumber, String password);

  Future<UserModel> getProfile();

  Future<Unit> updateLocation(Location location);

  Future<Unit> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> register(
      String phoneNumber, String password, String confirmPassword) async {
    final body = jsonEncode({
      "phone_number": phoneNumber,
      "password": password,
      "password2": confirmPassword,
    });

    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/user/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    return handleResponse(response);
  }

  @override
  Future<Unit> sendVerificationCode() async {
    dynamic token = await this.token;
    if (token == null) {
      token = "";
    }
    print("token : $token");
    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/user/sendverificationcode"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response);
    return handleResponse(response);
  }

  @override
  Future<Unit> verifyPhoneNumber(String code) async {
    dynamic token = await this.token;
    if (token == null) {
      token = "";
    }

    final body = jsonEncode({
      "code": code,
    });

    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/user/verifyphonenumber"),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    print(response.statusCode);

    return handleResponse(response);
  }

  @override
  Future<Unit> finishProfile(UserModel userModel) async {
    List<String> imagePaths = userModel.images
            ?.map((imageEntity) => imageEntity.image)
            .whereType<String>()
            .toList() ??
        [];
    List<http.MultipartFile> imageParts = [];
    for (String imagePath in imagePaths) {
      var imagePart = await http.MultipartFile.fromPath(
        'images',
        imagePath,
        contentType: MediaType('images', 'jpg'),
      );

      imageParts.add(imagePart);
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${dotenv.env['URL']}/user/finishprofile"),
    );
    final token = await this.token;
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    print(jsonEncode(userModel.interests));
    List<String> interests =
        userModel.interests?.map((e) => e.toString()).toList() ?? [];
    request.fields.addAll({
      'description': jsonEncode(userModel.description),
      'prompts': jsonEncode(userModel.prompts),
      'interests': jsonEncode(userModel.interests),
    });
    request.fields.addAll({
      'name': userModel.name!,
      'date_of_birth': userModel.dateOfBirth!.toIso8601String(),
      'gender': userModel.gender!,
      'plan': userModel.plan!,
      'location': jsonEncode(
          {"type": "Point", "coordinates": userModel.location!.coordinates})
      // TODO LATER
      // 'interests': jsonEncode(userModel.interests),
    });
    request.files.addAll(imageParts);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    // return handleResponse(response);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;

      throw ServerMessageException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> login(String phoneNumber, String password) async {
    print(phoneNumber);
    print(password);
    final body = jsonEncode({
      "phone_number": phoneNumber,
      "password": password,
    });
    print(body);
    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/user/login"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      saveToken(token);
      return UserModel.fromJson(responseBody['user']);
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;

      throw ServerMessageException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getProfile() async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/user/profile"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return UserModel.fromJson(responseBody);
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;
      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateLocation(Location location) async {
    // 'location': jsonEncode(
    // {"type": "Point", "coordinates": userModel.location!.coordinates})
    final body = jsonEncode({
      "location": {"type": "Point", "coordinates": location!.coordinates},
    });
    dynamic token = await this.token;
    token ??= "";
    final response = await client.patch(
      Uri.parse("${dotenv.env['URL']}/user/updatelocation"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: body,
    );
    return handleResponse(response);
  }

  @override
  Future<Unit> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    final body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "newPassword2": confirmNewPassword,
    };

    dynamic token = await this.token;

    final response = await client.patch(
      Uri.parse("${dotenv.env['URL']}/users/changePassword"),
      body: body,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return handleResponse(response);
  }

  Future<Unit> handleResponse(http.Response response) async {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (responseBody.containsKey('token')) {
        final token = responseBody['token'];
        saveToken(token);
      }
      return Future.value(unit);
    } else if (response.statusCode == 400) {
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 410) {
      final errorMessage = responseBody['message'] as String;

      UnauthorizedFailure.message = errorMessage;
      throw const UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  saveToken(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  Future<dynamic> get token async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}

// Sign out

// BlocProvider.of<SignOutBloc>(context)
//     .add(SignOutMyAccountEventPressed());
// return BlocConsumer<SignOutBloc, SignOutState>(
// builder: (context, state) {
// if (state is SignOutLoading) {
// return ReusablecircularProgressIndicator(
// height: 20.h,
// width: 20.w,
// indicatorColor: primaryColor,
// );
// } else {
// return const Text("errrorororororor");
// }
// }, listener: (context, state) {
// if (state is SignOutSuccess) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text(
// "Votre session a expiré , veuillez vous reconnecter"),
// backgroundColor: Colors.red,
// ),
// );
// navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
// context,
// SignInScreen(),
// );
// } else if (state is SignOutError) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text(state.message),
// backgroundColor: Colors.red,
// ),
// );
// }
// });
