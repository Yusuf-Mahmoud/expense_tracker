
import 'dart:io';
import 'package:expense_tracker/core/model/user.dart';
import 'package:expense_tracker/features/auth/cubit/logic.dart';
import 'package:expense_tracker/features/auth/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel? user;
  const EditProfilePage({ this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  File? _image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user?.name);
    emailController = TextEditingController(text: widget.user?.email);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() { _image = File(pickedFile.path); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess || state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Updated!")));
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null ? Icon(Icons.camera_alt, size: 40) : null,
                ),
              ),
              SizedBox(height: 30),
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Full Name")),
              SizedBox(height: 20),
              TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().updateProfile(
                    name: nameController.text,
                    email: emailController.text,
                  );
                },
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}