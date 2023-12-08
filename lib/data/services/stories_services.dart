import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:whats_app/data/core/api/url.dart';
import '../model/stories_model.dart';

class StoryServices {
  Future<List<StoryModel>> getStoryList() async {
    Response response = await http.get(Uri.parse(stories));
    List<StoryModel> storyList = storyModelFromJson(response.body);
    print(response.statusCode);
    return storyList;
  }
}