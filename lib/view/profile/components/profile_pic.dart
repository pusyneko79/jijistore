import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/userProfileModel.dart';
import '../../../services/sharedPreferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _profilePicState();
}

class _profilePicState extends State<ProfilePic> {
  UserProfileModel? user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileModel>(
        future: getUserDataFromSharedPreferences(),
        builder:
            (BuildContext context, AsyncSnapshot<UserProfileModel> snapshot) {
          return SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data?.img ??
                      "https://cdn-icons-png.flaticon.com/512/147/147133.png"),
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                      },
                      child: SvgPicture.asset("asset/icons/CameraIcon.svg"),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
