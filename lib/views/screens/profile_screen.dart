import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:saha_yatri/services/auth_service.dart';
import 'package:saha_yatri/views/widgets/custom_button.dart';
import 'package:saha_yatri/views/widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();
  }

// Loading data from Firestore database
  Future<void> fetchAndSetUserData() async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic>? userData =
          await _authService.fetchUserData(uid: currentUserUid);

      if (userData != null) {
        setState(() {
          usernameController.text = userData['username'] ?? '';
          emailController.text = userData['email'] ?? '';
          phoneController.text = userData['phone'] ?? 'No Data';
        });
      }
    } catch (e) {
      _authService.showToast(
          "Unknown error occoured", Colors.red, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile & Setting"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.user),
                    hintText: "Username",
                    controller: usernameController,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.mail),
                    hintText: "Email",
                    controller: emailController,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.phone),
                    hintText: "Phone (UID)",
                    controller: phoneController,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 80),

                  // Edit profile button
                  CustomButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      // Add functionality to update profile data if needed
                    },
                    text: "Save changes",
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 10),

                  // Logout button
                  CustomButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      AuthService().logOut();
                    },
                    text: "Log out",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
