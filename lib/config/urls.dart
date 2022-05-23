
class Urls{
  static String sendEmailUrl = "https://api.emailjs.com/api/v1.0/email/send";
  static String baseUrl = "https://healthcare-app0.herokuapp.com/";
  static String loginUrl = "user/login";
  static String getUserByEmailUrl = "user/getByEmail/";
  static String registerUrl = "user/register-for-mobile";
  static String resetPasswordUrl = "user/reset-password";
  static String createPatientUrl = "patient/create";
  static String getAllPatientsUrl = "patient/get-all";
  static String gatSinglePatientUrl = "patient/get/";
  static String updatePatientUrl = "patient/update/";
  static String deletePatientUrl = "patient/delete/";
  static String getAllHospitalsUrl = "hospital/get-all";
  static String getAllDepartments = "department/get-all";
  static String getAllDoctorsInDepartment = "dr-in-depart/get-by-dep/";
  static String uploadImage = "user/upload/";
  static String updateProfileUrl = "user/update/";
  static String sendAppointmentRequest = "appointment/create";
  static String getAllAppointments = "appointment/get-all";
  static String getAllPharmacies = "pharmacy/get-all";
  static String getAllMedicineInPharmacyByPharmacy = "medicine-pharmacy/get-by-pharmacy/";
  static String createOrder = "order/create";
  static String getAllOrders = "order/get-all-for-user/";
  static String getAllDoctors = "doctor/get-all";
  static String getAllAppointmentsByDr = "appointment/get-by-dr/";
  static String acceptAppointmentRequest = "appointment/update/";
  static String getAllRoles = "role/get-all";
  static String getAllRolesForUser = "user-access-roles/get-all/";
  static String getAllPosts = "post/get-all";
  static String createResponse = "response/create";
  static String getAllResponses = "response/get-all";
}