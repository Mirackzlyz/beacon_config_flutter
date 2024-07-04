// Örnek RSSI değerleri
List<int> rssiValues = [-50, -60, -70, -80, -90];

// RSSI değerlerine göre sıralama
rssiValues.sort();

// Sıralanmış RSSI değerlerini ve mesafeyi gösterme (örneğin)
for (int rssi in rssiValues) {
double distance = calculateDistanceFromRSSI(rssi); // RSSI değerinden mesafe hesaplaması
print('RSSI: $rssi, Distance: $distance meters');
}

// RSSI değerinden mesafe hesaplama fonksiyonu (örnek olarak)
double calculateDistanceFromRSSI(int rssi) {
// Burada gerçek bir hesaplama algoritması kullanılmalı
// Örneğin, basit bir şekilde ters kare yasası kullanabilirsiniz
return 10 ^ ((-50 - rssi) / (10 * 2));
}
