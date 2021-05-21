import 'package:app_food/food/model/resto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_food/food/model/data.dart';

class SearchScreen extends StatefulWidget {

  static const route = '/';
  final String RestoId;

  const SearchScreen({Key key, this.RestoId, restoId, currentUserId}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot> resto;
  TextEditingController _searchController = TextEditingController();

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      resto = null;
    });
  }

  buildUserTile(restos resto) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: resto.photo.isEmpty
            ? AssetImage('image/food/placeholder.png')
            : NetworkImage(resto.photo),
      ),
      title: Text(resto.name),
      onTap: () {

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            hintText: 'Search Twitter...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                clearSearch();
              },
            ),
            filled: true,
          ),
          onChanged: (input) {
            if (input.isNotEmpty) {
              setState(() {
                resto = data.searchName(input);
              });
            }
          },
        ),
      ),
      body: resto == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 200),
                  Text(
                    'Search Twitter...',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          : FutureBuilder(
              future: resto,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text('No users found!'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      restos resto =
                      restos.fromDoc(snapshot.data.documents[index]);
                      return buildUserTile(resto);
                    });
              }),
    );
  }
}
