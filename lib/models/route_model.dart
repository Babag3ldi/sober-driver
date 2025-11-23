class RouteModel {
  final String from;
  final String to;
  final int price;

  RouteModel(this.from, this.to, this.price);

  bool matches(String a, String b) =>
      (a == from && b == to) || (a == to && b == from);
}

List<RouteModel> yollar = [
  RouteModel("Ashgabat", "Ashgabat", 40),
  RouteModel("Ashgabat", "Buzmeyin", 60),
  RouteModel("Ashgabat", "Gökdepä", 100),
];
