import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import '../services/database.dart';

class Profile extends StatefulWidget {
  final String email;
  const Profile({Key? key, required this.email}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> uploadProfile() async {
    Map<String, dynamic> updatedInfo = {};

    // Update the name if the text field is not empty
    if (nameController.text.isNotEmpty) {
      updatedInfo['Name'] = nameController.text;
    }

    // Update the image if a new image has been selected
    if (selectedImage != null) {
      String userId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("profileImages").child(userId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      updatedInfo['Image'] = downloadUrl;
    }

    // If there are any updates to be made, update the Firestore document
    if (updatedInfo.isNotEmpty) {
      await DatabaseMethods().updateUserProfile(widget.email, updatedInfo);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0xFFfd6f3e),
        content: Text(
          'Profile Updated Successfully',
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    DocumentSnapshot userDoc =
        await DatabaseMethods().getUserDetailsByEmail(widget.email);
    setState(() {
      nameController.text = userDoc['Name'];
      // Note: Handling _image from Firestore should be handled with a NetworkImage, assuming the image is a URL string
      selectedImage =
          null; // Initialize with null since we are not loading the image as a File
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   backgroundColor: Color(0xFFfd6f3e),
      // ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 90.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!)
                      : AssetImage('images/profile.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadProfile,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
