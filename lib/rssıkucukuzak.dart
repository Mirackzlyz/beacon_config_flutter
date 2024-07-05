import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchRSSIData() async {
  final response = await http.get(Uri.parse('http://10.34.82.169/getDevices'));

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));

    // RSSI değerlerine göre sıralama
    data.sort((a, b) => a['rssi'].compareTo(b['rssi']));

    // Sıralanmış verileri ekrana yazdırma örneği
    for (var item in data) {
      print('BSSID: ${item['bssid']}, RSSI: ${item['rssi']}');
    }
  } else {
    print('HTTP GET hatası: ${response.statusCode}');
  }
}

void main() {
  fetchRSSIData();
}
