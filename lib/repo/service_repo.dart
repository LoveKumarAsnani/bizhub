import 'dart:convert';
import 'dart:developer';
import 'package:bizhub_new/model/service_model.dart';
import '../utils/app_url.dart';
import '../utils/shared_prefrences.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class ServiceRepository {
  final prefrence = Prefrences();

  // CREATE
  Future<dynamic> createService(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.createServiceEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> createGuestService(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.createGuestServiceEndPoint),
        body: data,
        // headers: await AppUrl().headerWithAuth(),
        headers: AppUrl.header,
      );

      print('createGuestService ${response.body}');
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  // All Services
  Future<Map<String, dynamic>> fetchAllServicesList({
    required String serviceType,
    required String long,
    required String lat,
    required String? miles,
    int? page,
  }) async {
    try {
      var catIds = "";
      var servicePage = "";

      for (var element
          in (await prefrence.getSharedPreferenceListValue("categories"))) {
        catIds += "&cat_ids[]=$element";
      }
      miles = miles != '' ? '&distance=$miles' : '&distance=2000';
      if (page == null) {
        servicePage = '';
      } else {
        servicePage = 'page=$page';
      }

      final response = await http.get(
        Uri.parse(
            '${AppUrl.allServiceEndPoint}?$servicePage&type=$serviceType$catIds&latitude=$lat&longitude=$long$miles'),
        headers: await AppUrl().headerWithAuth(),
      );

      // print(
      //     '${AppUrl.allServiceEndPoint}?$servicePage&type=$serviceType$catIds&latitude=$lat&longitude=$long$miles');

      // print('${AppUrl.allServiceEndPoint}?type=$serviceType');
      final loadedData = json.decode(response.body);
      // print(loadedData);
      if (response.statusCode == 200) {
        List<ServiceModel> allServicesList =
            (loadedData['data'] as List).map((e) {
          // print(e);
          return ServiceModel.fromJson(e);
        }).toList();
        return {
          'allService': allServicesList,
          'prev': loadedData['prev_page_url'],
          'next': loadedData['next_page_url'],
        };
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage('hello');
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchAllServicesWithoutAuthList({
    required String serviceType,
    required String long,
    required String lat,
    required String? miles,
    int? page,
  }) async {
    try {
      var catIds = "";
      var servicePage = "";

      for (var element
          in (await prefrence.getSharedPreferenceListValue("categories"))) {
        catIds += "&cat_ids[]=$element";
      }
      miles = miles != '' ? '&distance=$miles' : '&distance=2000';
      if (page == null) {
        servicePage = '';
      } else {
        servicePage = 'page=$page';
      }

      final response = await http.get(
        Uri.parse(
            '${AppUrl.withoutAuthAllServiceEndPoint}?$servicePage&type=$serviceType$catIds&latitude=$lat&longitude=$long$miles'),
        headers: AppUrl.header,
      );

      // print(
      //     '${AppUrl.withoutAuthAllServiceEndPoint}?$servicePage&type=$serviceType$catIds&latitude=$lat&longitude=$long$miles');
      // print('${AppUrl.allServiceEndPoint}?type=$serviceType');

      final loadedData = json.decode(response.body);
      print(loadedData);
      if (response.statusCode == 200) {
        List<ServiceModel> allServicesList = (loadedData['data'] as List).map(
          (e) {
            // print(e);
            return ServiceModel.fromJson(e);
          },
        ).toList();
        return {
          'allService': allServicesList,
          // 'prev': loadedData['links']['prev'],
          // 'next': loadedData['links']['next'],
          'prev': loadedData['prev_page_url'],
          'next': loadedData['next_page_url'],
        };
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage('hello');
    }
    return {};
  }

  Future<ServiceDetalModel?> fetchAllServiceDetailWithoutAuth({
    required String serviceId,
  }) async {
    ServiceDetalModel? allService;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.withoutAuthAllServiceDetailEndPoint}/$serviceId'),
        headers: AppUrl.header,
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      log("loadedData $loadedData");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ServiceModel myPosterService =
        //     loadedData['data'].map((e) => ServiceModel.fromJson(e)).toList();
        allService = ServiceDetalModel.fromJson(loadedData['data']);
        // print(myPosterService);
        return allService;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
    return allService;
  }

  Future<ServiceDetalModel?> fetchAllServiceDetail({
    required String serviceId,
  }) async {
    ServiceDetalModel? allService;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.myPosterServiceDetailEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ServiceModel myPosterService =
        //     loadedData['data'].map((e) => ServiceModel.fromJson(e)).toList();
        allService = ServiceDetalModel.fromJson(loadedData['data']);
        // print(myPosterService);
        return allService;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
    }
    return allService;
  }

  // POSTER
  Future<List<ServiceModel>> fetchMyPosterServiceList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.myPosertServiceEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceModel> myPosterServiceList = (loadedData['data'] as List)
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        return myPosterServiceList;
      } else {
        // Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
    }
    return [];
  }

  Future<ServiceModel?> fetchMyPosterService({
    required String serviceId,
  }) async {
    ServiceModel? myPosterService;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.myPosterServiceDetailEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ServiceModel myPosterService =
        //     loadedData['data'].map((e) => ServiceModel.fromJson(e)).toList();
        myPosterService = ServiceModel.fromJson(loadedData['data']);
        // print(myPosterService);
        return myPosterService;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
    }
    return myPosterService;
  }

  // WORKER
  Future<List<ServiceModel>> fetchMyWorkerServiceList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.myWorkerServiceEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceModel> myWorkerServiceList = (loadedData['data'] as List)
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        return myWorkerServiceList;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
    }
    return [];
  }

  // UPDATE
  Future<dynamic> updateService(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.updateMyServiceEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );

      final responseLoaded = jsonDecode(response.body);

      // print(responseLoaded);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      // Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  // BUMP UP
  Future<bool> bumpUpMyService({
    required String serviceId,
  }) async {
    // ServiceModel? myPosterService;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.bumpUpMyServiceEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        Utils.toastMessage(loadedData['message']);
        return false;
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
      return false;
    }
  }

  // DELETE
  Future<bool> deleteMyService({
    required String serviceId,
  }) async {
    // ServiceModel? myPosterService;
    try {
      final response = await http.delete(
        Uri.parse('${AppUrl.deleteMyServiceEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        Utils.toastMessage(loadedData['message']);
        return false;
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
      return false;
    }
  }

  // COMPLETE
  Future<ServiceCompleteModel?> fetchCompleteService({
    required String serviceId,
  }) async {
    ServiceCompleteModel? serviceCompleteModel;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.completeMyServiceEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ServiceModel myPosterService =
        //     loadedData['data'].map((e) => ServiceModel.fromJson(e)).toList();
        serviceCompleteModel =
            ServiceCompleteModel.fromJson(loadedData['data']);
        // print(myPosterService);
        return serviceCompleteModel;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // Utils.toastMessage(e.toString());
    }
    return serviceCompleteModel;
  }

  // RATE
  Future<dynamic> completeAndRate(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.rateAndCompleteServiceEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      // Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }
}
