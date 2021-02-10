import 'package:flutter/material.dart';
import 'package:future/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'User.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _getPosts() async {
    http.Response response = await http.get(_baseUrl + "/posts");
    var jsonData = json.decode(response.body);

    List<Post> postagens = List();
    for (var post in jsonData) {
      print("Post: " + post["title"]);
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);

      postagens.add(p);
    }

    return postagens;
  }

  _post() async {
    http.Response response = await http.post(
      _baseUrl + "/posts",
      headers: {
        "Content-type": "application/json; charset=UTF-8",
      },
      body: {
        "userId":1,
        "id":1,
        "title":"",
        "body":""
      }
    );
  }

  _put() {}
  _patch() {}
  _delete() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Web services"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<Post>>(
            future: _getPosts(),
            builder: (context, snapshot) {
              String result;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;

                case ConnectionState.active:
                case ConnectionState.done:
                  print("conecao done");
                  if (snapshot.hasError) {
                    result = "Erro ao carregar dados.";
                  } else {
                    return Column(children: [
                      Row(
                        children: [
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Salvar"),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Atualizar"),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Remover"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List<Post> lista = snapshot.data;
                            Post post = lista[index];

                            return ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.id.toString()),
                            );
                          },
                        ),
                      )
                    ]);
                  }
                  break;
              }
            },
          ),
        ));
  }
}
