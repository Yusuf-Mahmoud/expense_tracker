import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/auth/cubit/logic.dart';
import 'package:expense_tracker/features/auth/cubit/state.dart';
import 'package:expense_tracker/features/auth/login/login_screen.dart';
import 'package:expense_tracker/features/profile/edit_screen.dart';
import 'package:expense_tracker/features/profile/setting/setting_screen.dart';
import 'package:expense_tracker/features/profile/widget/profile_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            String name = "Guest User";
            String photoUrl = "";
            if (state is LoginSuccess) {
              name = state.info.name;
              photoUrl = state.info.photoUrl;
            }

            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.purple.shade100,
                        backgroundImage: photoUrl.isNotEmpty
                            ? NetworkImage(photoUrl)
                            : AssetImage('assets/images/person.png'),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      buildProfileOption(
                        icon: Icons.settings,
                        title: "Settings",
                        iconColor: ColorManager.primaryViolet,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SettingScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(height: 1, indent: 60),
                      buildProfileOption(
                        icon: Icons.edit,
                        title: "Edit Profile",
                        iconColor: Colors.blue,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 60),
                      buildProfileOption(
                        icon: Icons.logout,
                        title: "Logout",
                        iconColor: ColorManager.expenseRed,
                        textColor: ColorManager.expenseRed,
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
