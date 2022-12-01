import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/home/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final model = HomeModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Instagram 에 오신것을 환영합니다.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('사진과 동영상을 보려면 팔로우 하세요.'),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: GestureDetector(
                        onTap: () async {
                          await model.updateProfileImage();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(model.getProfileImageUrl()),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.getEmail(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(model.getNickName()),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://img.hankyung.com/photo/202208/03.30968100.1.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Image.network(
                          'https://blog.kakaocdn.net/dn/drkKUz/btrKzPmA6Xi/cLjppsVnQYYF2dggTuvCf0/img.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Image.network(
                          'https://blog.kakaocdn.net/dn/drkKUz/btrKzPmA6Xi/cLjppsVnQYYF2dggTuvCf0/img.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        // Image.network(
                        //   'https://photo.newsen.com/news_photo/2022/08/19/202208190914415510_1.jpg',
                        //   width: 100,
                        //   height: 100,
                        //   fit: BoxFit.cover,
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Facebook 친구'),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('팔로잉 하기'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
