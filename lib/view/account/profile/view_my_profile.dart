import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/auth_view_model.dart';
import '../component/view_profile.dart';

class ViewMyProfile extends StatefulWidget {
  const ViewMyProfile({Key? key}) : super(key: key);

  @override
  State<ViewMyProfile> createState() => _ViewMyProfileState();
}

class _ViewMyProfileState extends State<ViewMyProfile> {
  getData() {
    final auth = context.read<AuthViewModel>();
    auth.setPrefrenceValues();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    // final size = MediaQuery.of(context).size;

    // print(auth.getPrefrenceValue('image'));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.editMyProfile);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewProfile(
            userName:
                '${auth.getPrefrenceValue('firstName')} ${auth.getPrefrenceValue('lastName')}',
            userImage: auth.getPrefrenceValue('image').isEmpty
                ? 'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'
                : AppUrl.baseUrl + auth.getPrefrenceValue('image'),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'About',
              style: TextStyle(
                // color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No description added yet.',
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    color: Colors.grey.shade500,
                  ),
                ),
                GestureDetector(
                  child: const Text(
                    "www.google.com",
                    // viewProfile.response['url'] ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      // decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () async {
                    const url = 'https://www.google.com';
                    // var url =
                    //     'https://' + viewProfile.response['url'].toString();
                    if (await canLaunch(url)) launch(url);
                  },
                ),
              ],
            ),
          ),
          // Text(
          //   '${authViewModel.user!.firstName}',
          //   textAlign: TextAlign.start,
          //   style: TextStyle(
          //     // decoration: TextDecoration.underline,
          //     color: Colors.blue,
          //   ),
          // ),
        ],
      ),
    );
  }
}
