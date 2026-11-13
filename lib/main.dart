import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

void main() async {
  print('=== 8.4 Ручная сериализация списка (Отображение данных) ===');
  
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=3');
  
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      List<Post> posts = jsonList.map((item) => Post.fromJson(item)).toList();

      print('Успешно загружено и распарсено постов: ${posts.length}\n');

      for (var post in posts) {
        print('ID постов: ${post.id}');
        print('Заголовок: ${post.title}');
        print('Текст: ${post.body.substring(0, 50)}...');
        print('-------------------------------------------');
      }
    } else {
      print('Ошибка: ${response.statusCode}');
    }
  } catch (e) {
    print('Ошибка сети: $e');
  }
}