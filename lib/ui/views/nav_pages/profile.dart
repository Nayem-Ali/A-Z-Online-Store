import 'package:ecommerce/model/user_profile.dart';
import 'package:ecommerce/services/firestore_db.dart';
import 'package:ecommerce/ui/widgets/custom_button.dart';
import 'package:ecommerce/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreDB().getUserProfile(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserProfile userProfile = snapshot.data as UserProfile;
            _nameController.text = userProfile.name;
            _emailController.text = userProfile.email;
            _uidController.text = userProfile.uid;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Column(
                  children: [
                    customFormField(TextInputType.text, _nameController, context, "Name", (val) {},
                        prefixIcon: Icons.person_outlined),
                    customFormField(
                      TextInputType.emailAddress,
                      _emailController,
                      context,
                      "Email",
                      (val) {},
                      prefixIcon: Icons.email_outlined,
                      readOnly: true,
                    ),
                    customFormField(
                      TextInputType.text,
                      _uidController,
                      context,
                      "User ID",
                      (val) {},
                      prefixIcon: Icons.verified_outlined,
                      readOnly: true,
                    ),
                    customButton("Update Profile", () async {
                      final updatedData = UserProfile(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        uid: _uidController.text.trim(),
                      );
                      await FirestoreDB().updateUserProfile(updatedData);
                    })
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
