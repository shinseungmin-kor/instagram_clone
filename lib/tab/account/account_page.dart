import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/account/account_model.dart';

import '../../detail_post/detail_post_page.dart';
import '../../domain/post.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Clone'),
        actions: [
          IconButton(
              onPressed: () {
                model.logout();
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(model.getProfileImageUrl()),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: const [
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: FloatingActionButton(
                                  onPressed: null,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(
                                  onPressed: null,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.getNickName(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot<Post>>(
                      stream: model.postsStream,
                      builder: (context, snapshot) {
                        int count = 0;
                        if(snapshot.hasData) {
                          count = snapshot.data!.size;
                        }
                        return Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '게시물',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '팔로워',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '팔로잉',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot<Post>>(
                stream: model.postsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('알 수 없는 에러');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Post> posts =
                      snapshot.data!.docs.map((e) => e.data()).toList();

                  return Expanded(
                    child: GridView.builder(
                        itemCount: posts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // mainAxisSpacing: 1.0,
                          crossAxisCount: 3,
                          // crossAxisSpacing: 2.0
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final post = posts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPostPage(post: post)));
                            },
                            child: Hero(
                              tag: post.id,
                              child: Image.network(
                                post.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
