class AppUrl {
  // static const String baseUrl = "http://10.0.2.2:5000";
  // static const String baseUrl = "http://192.168.1.29:5000";          172.20.10.4      172.20.10.7
  
  static const String baseUrl = "http://10.50.47.125:5000";
  static const String loginUser = "$baseUrl/login_user";
  static const String getOnlyOneUser = "$baseUrl/get_onlyOne_user";
  static const String getVehicle = "$baseUrl/vehicle_infor";
  static const String removeVehicle = "$baseUrl/remove_active_vehicle";
  static const String verifyVehicle = "$baseUrl/upload";
  static const String addVehicle = "$baseUrl/add_vehicle";
  static const String updateVehicle = "$baseUrl/update_vehicle";
  static const String login = "$baseUrl/login";
  static const String getAllVehicle = "$baseUrl/get_all_vehicle";
  static const String getLogs = "$baseUrl/get_logs";
  static const String getStaff = "$baseUrl/get_staff";
  static const String removeStaff = "$baseUrl/remove_staff";
  static const String addStaff = "$baseUrl/add_staff";
  static const String updateStaff = "$baseUrl/update_staff";
  static const String getLogTable = "$baseUrl/get_logs_table";
  static const String getAllVehicleAdmin = "$baseUrl/get_all_vehicle_admin";
  static const String sendSMS = "$baseUrl/send_sms";
  static const String getRequest = "$baseUrl/get_request";
  static const String accpectRequest = "$baseUrl/accpect_request";
  static const String removeRequest = "$baseUrl/remove_request";
}
