import 'package:api_app/data/services/api_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Create mock classes
class MockClient extends Mock implements http.Client {}
class MockApiService extends Mock implements ApiService {}
