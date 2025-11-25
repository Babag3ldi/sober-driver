class Marshut {
  String aCity = "";
  String bCity = "";
  int baha = 0;
  Marshut({required this.aCity, required this.bCity, required this.baha});

  bool ispresent(String A, B) {
    if (A == aCity && B == bCity) return true;
    if (B == aCity && A == bCity) return true;
    return false;
  }

  num bahasy(String A, B) {
    if (A == aCity && B == bCity) return baha;
    if (B == aCity && A == bCity) return baha;
    return 0;
  }
}
