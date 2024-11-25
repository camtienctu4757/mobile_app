//previous
// class DeviceConstants {
//   const DeviceConstants._();

//   static const designDeviceWidth = 375.0;
//   static const designDeviceHeight = 667.0;

//   static const maxMobileWidth = 450;
//   static const maxTabletWidth = 900;

//   static const maxMobileWidthForDeviceType = 550;
// }

//custom
class DeviceConstants {
  const DeviceConstants._();

  // Kích thước thiết kế mẫu cho các thiết bị từ 6 đến 6.5 inch
  static const designDeviceWidth = 414.0;  // 6.1 inch (iPhone 11/12/13/14)
  static const designDeviceHeight = 896.0;

  // Điểm ngắt cho các thiết bị khác nhau
  static const maxMobileWidth = 450;       // Điện thoại di động
  static const maxTabletWidth = 900;       // Máy tính bảng

  // Điểm ngắt cho loại thiết bị di động lớn (phablet)
  static const maxMobileWidthForDeviceType = 600; // Các thiết bị từ 6 đến 6.5 inch
}
