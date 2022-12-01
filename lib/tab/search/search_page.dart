import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/create/create_page.dart';
import 'package:instagram_clone/detail_post/detail_post_page.dart';
import 'package:instagram_clone/domain/post.dart';
import 'package:instagram_clone/tab/search/search_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  final List<String> _urls = const [
    'https://img.hankyung.com/photo/202208/03.30968100.1.jpg',
    'https://blog.kakaocdn.net/dn/drkKUz/btrKzPmA6Xi/cLjppsVnQYYF2dggTuvCf0/img.png',
    'https://i.ytimg.com/vi/LcS-451yDxI/maxresdefault.jpg',
    'https://i.ytimg.com/vi/BTAtC5vksC0/maxresdefault.jpg',
    'https://thumbs.gfycat.com/EnchantedBogusGroundbeetle-size_restricted.gif',
    'https://i.ytimg.com/vi/RZ-fEUDXfmE/maxresdefault.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final model = SearchModel();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        child: const Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: StreamBuilder<QuerySnapshot<Post>>(
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

            return GridView.builder(
                itemCount: posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                });
          }),
    );
  }
}
