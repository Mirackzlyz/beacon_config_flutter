import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchRSSIData() async {
  final response = await http.get(Uri.parse('http://server endpoınt adres yaz'));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);

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
