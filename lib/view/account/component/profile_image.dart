import 'dart:io';
import 'package:bizhub_new/view/account/component/select_photo.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../utils/utils.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.userImage,
  }) : super(key: key);

  final String? userImage;

  @override
  Widget build(BuildContext context) {
    // final profileViewModel = Provider.of<AuthViewModel>(context, listen: true);
    // print('data image: ' + userImage.toString());
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, _) {
        // print('pathimg: ' + authViewModel.imageDetail['imagePath'].toString());
        final imagePath = authViewModel.imageDetail['imagePath'].toString();
        final localImage = authViewModel.imageDetail['local'];

        // print('img path' + imagePath);
        return GestureDetector(
          onTap: () => _showSelectPhoto(context),
          child: SizedBox(
            height: 160,
            width: 160,
            child: Stack(
              children: [
                if (imagePath.isEmpty && userImage == null.toString())
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.person, 
                      size: 120,
                      color: Colors.black54,
                    ),
                  ),
                if (imagePath.isNotEmpty || localImage == true)
                  Center(
                    child: Container(
                      width: 135,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              authViewModel.imageDetail['imagePath'].toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (userImage!.isNotEmpty && localImage == false)
                  Center(
                    child: Container(
                      width: 135,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppUrl.baseUrl + userImage!),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    // width: 32,
                    // height: 32,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: MyTheme.greenColor,
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: MyTheme.whiteColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSelectPhoto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.20,
        maxChildSize: 0.26,
        minChildSize: 0.20,
        expand: false,
        builder: (context, scrollController) {
          return Consumer<AuthViewModel>(
            builder: (context, authViewModel, _) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 10,
                      child: Container(
                        width: 50,
                        height: 4,
                        // margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          SelectPhoto(
                            textLabel: 'Select from Gallery',
                            icon: Icons.image,
                            onTap: () async {
                              var image = await Utils().getImageFromSource(
                                context,
                                ImageSource.gallery,
                              );
                              if (image == null) return;
                              authViewModel.setImage(
                                context: context,
                                file: image,
                              );
                            },
                          ),
                          // const SizedBox(height: 5),
                          SelectPhoto(
                            onTap: () async {
                              var image = await Utils().getImageFromSource(
                                context,
                                ImageSource.camera,
                              );
                              if (image == null) return;
                              authViewModel.setImage(
                                context: context,
                                file: image,
                              );
                            },
                            textLabel: 'Select from Camera',
                            icon: Icons.camera_alt_outlined,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
