import 'package:flutter/material.dart';
import '/models/post.dart';
import '/services/post_service.dart';
import '/widgets/post_card.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late Future<List<Post>> _posts;
  //buat nandain var ini bakal diisi nanti

  @override
  void initState() {
    super.initState();
    _posts = PostService.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _posts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
            //dari snapshot yang didapat apakah sudah ada datanya atau belum
                .map(
                  (post) => PostCard(
                    title: post.title,
                    body: post.body,
                  ),
                )
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}