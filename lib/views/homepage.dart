import 'package:flutter/material.dart';
import 'package:news_app/models/post.dart';
import 'package:news_app/services/remote_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //投稿のリスト
  List<Post>? posts;

  //API応答が読み込まれたか追跡するフラグ
  var isLoaded = false;

  //ページの初期化時にpost.dartからデータを読み込む
  @override
  void initState() {
    super.initState();
    //fetch date from API
    getData();
  }

  //データ取得
  getData() async {
    //post = await
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        //受け取っっている場合、trueが読み込まれる
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Visibility(
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300]),
                    ),
                    SizedBox(width: 16),
                    //右側のoverflow解消のためExpandedを追加
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posts![index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          //bodyはnullの可能性があるため、nullの場合の処理を追加
                          Text(
                            posts![index].body ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        replacement: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
