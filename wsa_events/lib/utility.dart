String formatDate(String date) {
  final d = date.split('-');
  return d[2] + '/' + d[1] + '/' + d[0];
}

List<String> pickHourAndDate(String dateHour) {
  final dt = dateHour.split('T');
  final date = formatDate(dt[0]);
  final hour = dt[1].substring(0, 5);
  return [hour, date];
}