class AppointData {
  List<String> date = [];
  List<String> year = [];
  List<String> time = [];

  pushData(String date, String year, String time) {
    print("here");
    this.date.add(date);
    this.year.add(year);
    this.time.add(time);
  }

  popData(String date, String year, String time) {
    this.date.remove(date);
    this.year.remove(year);
    this.time.remove(time);
  }

  disposeAppointmentData() {
    print("data Disposed");
    this.date = [];
    this.year = [];
    this.time = [];
  }

  returnDate() {
    return date[0];
  }

  returnTime() {
    return time[0];
  }

  returnYear() {
    return year[0];
  }
}
