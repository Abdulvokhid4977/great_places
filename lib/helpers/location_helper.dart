import 'package:http/http.dart' as http;
import 'dart:convert';

const googleApiKey='AIzaSyClHEQHzXwfYhQCIgPHzYsr2HoC-AnVOHk';
class LocationHelper{
  static String generateLocationPreviewImage({required double? latitude, required double? longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$googleApiKey';

  }
static Future<String> getLocationAddress(double lat, double lng) async{
    final url=Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey');
    final response=await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
}


}