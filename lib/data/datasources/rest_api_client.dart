import 'package:dio/dio.dart';
import 'package:git_repos_search/data/entity/git_repo_response_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api_client.g.dart';

@RestApi(baseUrl: 'https://api.github.com/')
abstract class RestApiClient {
  factory RestApiClient(Dio dio, {String baseUrl}) = _RestApiClient;

  @GET('/search/repositories/')
  Future<GitRepoResponseEntity> fetchGitRepos(
      @Query('q') String query,
      @Query('per_page') int itemsCount,
      );
}
