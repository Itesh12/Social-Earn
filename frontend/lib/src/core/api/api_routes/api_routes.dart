class ApiRoutes {
  ///BASE_URL
  static String baseUrl = 'https://social-earn.onrender.com/api/v1/';

  ////////////////////////Auth Routes /////////////////////
  static String register = '${baseUrl}users/register';
  static String login = '${baseUrl}users/login';

//////////////////////// Community Routes /////////////////////
  static String createCommunity = '${baseUrl}communities';
  static String getAllCommunities = '${baseUrl}communities';
  static String subscribeCommunities(String communityId) {
    return '${baseUrl}communities/$communityId/subscribe';
  }

  static String unsubscribeCommunities(String communityId) {
    return '${baseUrl}communities/$communityId/unsubscribe';
  }
}
