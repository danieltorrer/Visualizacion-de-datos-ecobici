//-99.2166,19.3975,-99.1277,19.4499

// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */

PImage bg;
Table table, estacionesTable;

int[] colores = { 
  #57fcc4, #ffd332, #fb6622, #a358d7, #60adb5, #ff4455, #9de836};

PFont f;
PFont flight;

int canvasX = 1100;
int canvasY = 687;

float xDegree = -99.2166;
float yDegree = 19.3975;

Viaje viajes[];
Viaje arrayDibujo[]; // = new Viaje[tamano];
Viaje viaje;
int tamano;

int lineaGrafica;

String currentDate;

int current = 0; //elemento actual del array

long lastTime = 0;


void setup() {
  lastTime = millis();

  f = createFont("Gotham Medium", 16, true);
  flight = createFont("Gotham Light", 16, true);
  textFont(f, 20);
  //cargarmapa
  size(1100, 687);
  bg = loadImage("img/bici2.png");
  background(bg);

  //abrir csv
  readEstacionesCSV();
  tamano = readViajeCSV();
  viajes = new Viaje[tamano];
  arrayDibujo = new Viaje[tamano];
  //crear puntos y viajes
  int id;
  String salida;
  String llegada;
  String estacion_salida; 
  String estacion_llegada;
  int cont = 0;
  int rand;
  int colore;
  for (TableRow row : table.rows()) {
    id = Integer.parseInt(row.getString("bike").trim());
    salida = row.getString("DaterRemoved");
    llegada = row.getString("dateArriver");
    estacion_salida = row.getString("stationRemoved"); 
    estacion_llegada = row.getString("stationArrived");
    colore = colores[ Integer.parseInt( estacion_salida ) % 7 ];
    viaje = new Viaje( getEstacion(estacion_salida), getEstacion(estacion_llegada), salida, llegada, colore );
    viajes[cont] = viaje;
    cont++;
  }

  //crear canvas
  int x, y;
  //Punto punti = new Punto()
  x = (int) degreesToXPixels(-99.172662);
  y = (int) degreesToYPixels(19.423655);
  //println(x+'\n');
  //println(y+'\n');
  fill(255, 68, 85);
  stroke(255, 68, 85);
  ellipse(x, y, 3, 3);

  for (int j=0;j<tamano;j++) {
    fill(255, 68, 85);
    stroke(255, 68, 85);
    smooth();
    ellipse(viajes[j].x, viajes[j].y, 5, 5);
  }
}

int ie = 6;
int ow = 0;

void draw() {

  if ( millis() - lastTime > 50 ) {
    background(bg);
    drawEstaciones();
    currentDate = buildDate(ie, ow);

    stroke(#000000, 100);
    fill(#000000, 100);
    rect(0, 0, 210, 687);

    fill(255);
    textFont(f, 26);
    text(currentDate+" hrs.", 15, 30);
    textFont(flight, 18);
    text("\nCiudad de México", 15, 30);

    //señales
    fill(255);
    stroke(255);
    rect(15, 200, 10, 10);

    textFont(flight, 16);
    text("\nEstaciones", 15, 215);
    
    lineaGrafica = 0;
    for (int i=0;i< colores.length;i++) {
      fill(colores[i]);
      stroke(colores[i]);
      rect(15 + (15*i), 265, 10, 10);
    }

    fill(255);
    stroke(255);
    textFont(flight, 16);
    text("\nUsuarios", 15, 280);


    for (int j=0;j<tamano;j++) {
      if (viajes[j].mover(ie, ow)) {
        lineaGrafica ++;
        fill(viajes[j].colora);
        stroke(viajes[j].colora);
        smooth();
        ellipse(viajes[j].x, viajes[j].y, 1, 1);
      }
    }
    fill(255);
    stroke(255);
    textFont(flight, 16);
    text("\nIntensidad", 15, 360);
    
    strokeWeight(2);
    stroke(#9de836);
    line(15,385, 15 + ceil(lineaGrafica/4), 385);
    
    
    
    ow++;
    ow = ow%60;
    if (ow == 0) {
      ie++;
    }
    if (ie>23) {
      //lineaGrafica = 0;
      noLoop();
    }
    //saveFrame("video/frame-#########.png");
    lastTime = millis();
    
  }
}

Punto getEstacion(String find) {
  TableRow result = estacionesTable.findRow(find, "id");
  return new Punto( degreesToXPixels (result.getFloat("longitude") ), degreesToYPixels( result.getFloat("latitude")) );
}

