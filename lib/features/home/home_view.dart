import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app_color.dart';
import 'package:note_app/features/notes/notes_view.dart';
import 'widgets/home_crad.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    getDate();
  }

  List<QueryDocumentSnapshot> data = [];
  Future<void> getDate() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('signin');
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 20,
              ))
        ],
        title: Text(
          'Home Page',
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: data.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotesView(
                      name: data[index]['name'], docId: data[index].id)));
            },
            onLongPress: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.bottomSlide,
                btnOkText: 'تعديل',
                btnOkColor: AppColor.primary,
                btnOkOnPress: () {
                  Navigator.of(context).pushNamed('edit', arguments: {
                    'id': data[index].id,
                    'oldName': data[index]['name'],
                  });
                },
                btnCancelText: 'حذف',
                btnCancelOnPress: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    'home',
                    (route) => false,
                  );
                  FirebaseFirestore.instance
                      .collection('categories')
                      .doc(data[index].id)
                      .delete();
                },
              ).show();
            },
            child: HomeCard(title: data[index]['name'])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add');
        },
        backgroundColor: AppColor.secondColor,
        child: Icon(
          Icons.add,
          color: AppColor.white,
          size: 35,
        ),
      ),
    );
  }
}
