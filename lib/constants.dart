
var verificationCode = '';
var isLoginScreen = true;
var isOTPScreens = false;
var isRegister = true;
bool isUserADoctor = false;

bool showSpinner = false;


List<Map<String, dynamic>> docCategories=[
  {"icon": "images/Doctor_types/pediatrician.png", "text": "Pediatrician"},
  {"icon": "images/Doctor_types/dermatologist.png", "text": "Dermatologist"},
  {"icon": "images/Doctor_types/ophthalmologist.png", "text": "Ophthalmologist"},
  {"icon": "images/Doctor_types/cardiologist.png", "text": "Cardiologist"},
  {"icon": "images/Doctor_types/obstetrician.png", "text": "Obstetrician"},
  {"icon": "images/Doctor_types/neurologist.png", "text": "Neurologist"},
  {"icon" : "images/Doctor_types/oncologist.png", "text" : "Oncologist"},
  {"icon" : "images/Doctor_types/anesthesiologist.png", "text" : "Anesthesiologist"},
  {"icon" : "images/Doctor_types/physiotherapist.png", "text" : "Physiotherapist"}
];




