import 'dart:convert';

import 'package:http/http.dart' as http;

class BlogRepository {
  List<dynamic> blogs = [];

  Future<List<dynamic>> fetchBlogs() async {
    const String apiUrl = "https://gql.hashnode.com/";
    const String query = '''
    {
      publication(host: "amarjitmallick.hashnode.dev") {
        posts(first: 10) {
          edges {
            node {
              id
              title
              publishedAt
              brief
              url
              coverImage {
                url
              }
            }
          }
          pageInfo {
            hasNextPage
          }
        }
      }
    }
    ''';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      blogs.clear();
      blogs = data['data']['publication']['posts']["edges"];
    }

    return blogs;
  }
}
