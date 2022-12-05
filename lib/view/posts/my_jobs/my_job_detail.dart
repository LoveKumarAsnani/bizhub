import 'package:bizhub_new/view/posts/components/my_post_detail.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_lodaer.dart';
// import '../components/edit_my_post.dart';
// import '../components/poster_detail_body.dart';

class MyJobDetail extends StatefulWidget {
  const MyJobDetail({
    required this.serviceId,
    Key? key,
  }) : super(key: key);

  final String serviceId;

  @override
  State<MyJobDetail> createState() => _MyJobDetailState();
}

class _MyJobDetailState extends State<MyJobDetail> {
  getMyPosterServiceDetail() async {
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    await provider.getMyPostDetail(
      context: context,
      serviceId: widget.serviceId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getMyPosterServiceDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    // final myServiceViewModel =
    //     Provider.of<MyServiceViewModel>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          Consumer<MyServiceViewModel>(
            builder: (context, myServiceViewModel, _) {
              if (myServiceViewModel.loading) {
                return const CustomLoader();
              } else {
                return MyPostDetail(myServiceViewModel: myServiceViewModel);
              }
            },
          ),
          // Positioned(
          //   top: 0,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height * 0.10,
          //     width: MediaQuery.of(context).size.width,
          //     alignment: Alignment.bottomLeft,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           Colors.transparent.withOpacity(0.2),
          //           Colors.transparent.withOpacity(0.1),
          //           Colors.transparent,
          //         ],
          //         stops: const [
          //           0.1,
          //           0.5,
          //           0.9,
          //         ],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           width: 40,
          //           height: 50,
          //           margin: const EdgeInsets.symmetric(horizontal: 12),
          //           // decoration: const BoxDecoration(
          //           // color: Colors.white,
          //           // shape: BoxShape.circle,
          //           // ),
          //           child: InkWell(
          //             onTap: () {
          //               Navigator.of(context).pop();
          //             },
          //             child:
          //                 const Icon(Icons.arrow_back_ios, color: Colors.white),
          //           ),
          //         ),
          //         Container(
          //           width: 40,
          //           height: 50,
          //           margin: const EdgeInsets.symmetric(horizontal: 12),
          //           child: myServiceViewModel.serviceModel!.serviceStatus == '0'
          //               ? InkWell(
          //                   onTap: () {
          //                     Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                         builder: (context) => const EditMyPost(),
          //                         settings: RouteSettings(
          //                           arguments: myServiceViewModel.serviceModel,
          //                         ),
          //                       ),
          //                     );
          //                   },
          //                   child: const Icon(Icons.edit, color: Colors.white),
          //                 )
          //               : const SizedBox(),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
