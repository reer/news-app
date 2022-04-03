// インターネットからデータを取得
import 'package:http/http.dart' as http;
import 'package:news_app/models/post.dart';

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //getリクエスト
    var response = await client.get(uri);
    //成功した場合
    if (response.statusCode == 200) {
      //app.quicktypeから生成したメソッドに渡す
      var json = response.body;
      return postFromJson(json);
    }
  }
}

//httpの呼び出しを行うには、flutter pub add http
