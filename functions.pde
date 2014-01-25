public int degreesToXPixels(float degrees) {
  return  (int) abs( (xDegree - degrees)  * 12373.4531);
}

public int degreesToYPixels(float degrees) {
  return  (int) abs ((yDegree - degrees) * 13110.6870);
}


int readViajeCSV() {
  table = loadTable("lastday.csv", "header");
  return table.getRowCount();
}

void readEstacionesCSV() {
  estacionesTable = loadTable("ecobiciestaciones.csv", "header");
}

void drawEstaciones() {
  int total = estacionesTable.getRowCount();
  for (TableRow row : estacionesTable.rows()) {
    fill(#ffffff);
    stroke(#ffffff);
    smooth();
    ellipse( degreesToXPixels(row.getFloat("longitude") ), degreesToYPixels( row.getFloat("latitude")), 1, 1);
  }
}

String buildDate(int h, int m) {
  String hora, minuto;
  if ( h < 10)
    hora = "0"+h;
  else
    hora = ""+h;

  if (m < 10)
    minuto = "0"+m;
  else
    minuto = ""+m;

  return hora+":"+minuto;
}

