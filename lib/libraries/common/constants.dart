const String baseUrl = 'https://www.tabnews.com.br/api/v1';

/* TABS */

String getContentsUrl({
  required int page,
  required int perPage,
  required String strategy,
}) {
  return '$baseUrl/contents?page=$page&per_page=$perPage&strategy=$strategy';
}

String getTabUrl({required String ownerUsername, required String slug}) {
  return '$baseUrl/contents/$ownerUsername/$slug';
}

String getTabCommentsUrl(
    {required String ownerUsername, required String slug}) {
  return '$baseUrl/contents/$ownerUsername/$slug/children';
}

const String getUserUrl = '$baseUrl/user';

const String postContentUrl = '$baseUrl/contents';

/* AUTH */

const String loginUrl = '$baseUrl/sessions';
const String registerUrl = '$baseUrl/users';
const String recoveryPasswordUrl = '$baseUrl/recovery';

/* USER */

String getUserContentsUrl(
    {required String username,
    required int page,
    required int perPage,
    required String strategy}) {
  return '$baseUrl/$username?page=$page&per_page=$perPage&strategy=$strategy';
}
