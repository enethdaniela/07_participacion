enum ModoRedondeo { exacto, haciaArriba }

abstract interface class EstrategiaRedondeo {
  double redondear(double valor);
}
