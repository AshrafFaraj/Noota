import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app_color.dart';
import '../auth/views/widgets/custom_button.dart';
import '../auth/views/widgets/custom_text_field.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> addCategory() async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');
    isLoading = true;
    setState(() {});
    await categories.add({
      'name': controller.text,
      'uid': FirebaseAuth.instance.currentUser!.uid
    }).then((val) {
      print('================ Added successfully');
      Navigator.of(context).pushNamedAndRemoveUntil(
        'home',
        (route) => false,
      );
    }).catchError((e) {
      isLoading = false;
      setState(() {});
      print('======================= failed to add ${e.toString()}');
      AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              title: 'Error',
              dialogType: DialogType.error)
          .show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        controller: controller,
                        label: 'add',
                        hint: 'add new category'),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onPressed: () {
                          addCategory();
                        },
                        color: AppColor.secondColor,
                        title: 'Add'),
                    AddCategories('catogories'),
                  ],
                ),
              ),
      ),
    );
  }
}

class AddCategories extends StatelessWidget {
  final String name;

  const AddCategories(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');

    Future<void> addCategories() {
      // Call the user's CollectionReference to add a new user
      return categories
          .add({
            'name': name, // John Doe
          })
          .then((value) => Navigator.of(context).pop())
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addCategories,
      child: Text(
        "Add Categories",
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName(this.documentId, {super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}
