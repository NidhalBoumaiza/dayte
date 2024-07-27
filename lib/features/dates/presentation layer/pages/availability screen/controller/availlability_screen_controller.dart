import 'package:get/get.dart';

class AvailabilityScreenController extends GetxController {
  RxBool isLoaded = false.obs;

  RxList<Map<String, String>> myMap = <Map<String, String>>[].obs;

  void addDay(String dayName, String date) {
    myMap.add({"day": dayName, "time": date});
    print(myMap);
  }

  void deleteDay(String dayName) {
    myMap.removeWhere((element) => element["day"] == dayName);
  }
}
