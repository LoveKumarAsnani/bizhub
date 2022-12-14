// import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_url.dart';
import '../../../view_model/my_service_view_model.dart';
import 'edit_my_post.dart';
import 'my_google_map.dart';

class MyPostDetail extends StatelessWidget {
  const MyPostDetail({
    Key? key,
    required this.myServiceViewModel,
  }) : super(key: key);

  final MyServiceViewModel myServiceViewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.28,
                child: myServiceViewModel.serviceModel!.imagesList!.isEmpty
                    ? Container(
                        color: Colors.black,
                        child: Image.asset('assets/images/bizhub_logo.png'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            myServiceViewModel.serviceModel!.imagesList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final serviceImages = myServiceViewModel
                              .serviceModel!.imagesList![index];
                          return Stack(
                            children: [
                              Container(
                                // margin: const EdgeInsets.only(right: 2.0),
                                height: size.height,
                                width: size.width,
                                decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  // borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      AppUrl.baseUrl +
                                          serviceImages.image.toString(),
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}/${myServiceViewModel.serviceModel!.imagesList!.length}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${myServiceViewModel.serviceModel!.serviceAmount.toString()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      myServiceViewModel.serviceModel!.serviceTitle.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      myServiceViewModel.serviceModel!.serviceDesc.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MyGoogleMap(myServiceViewModel: myServiceViewModel),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent.withOpacity(0.2),
                    Colors.transparent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.1,
                    0.5,
                    0.9,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icons.arrow_back_ios,
                  ),
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   margin: const EdgeInsets.symmetric(horizontal: 12),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //     child: const Icon(
                  //       Icons.arrow_back_ios,
                  //       color: MyTheme.greenColor,
                  //     ),
                  //   ),
                  // ),

                  // Container(
                  //   width: 40,
                  //   height: 50,
                  //   margin: const EdgeInsets.symmetric(horizontal: 12),
                  //   child: myServiceViewModel.serviceModel!.serviceStatus == '0'
                  //       ? InkWell(
                  //           onTap: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => const EditMyPost(),
                  //                 settings: RouteSettings(
                  //                   arguments: myServiceViewModel.serviceModel,
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //           child: const Icon(
                  //             Icons.edit,
                  //             color: MyTheme.greenColor,
                  //           ),
                  //         )
                  //       : const SizedBox(),
                  // ),
                  myServiceViewModel.serviceModel!.serviceStatus == '0'
                      ? _actionButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditMyPost(),
                                settings: RouteSettings(
                                  arguments: myServiceViewModel.serviceModel,
                                ),
                              ),
                            );
                          },
                          icon: Icons.edit,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white.withAlpha(30),
        child: Center(child: Icon(icon, color: Colors.white, size: 22)),
      ),
    );
  }
}
