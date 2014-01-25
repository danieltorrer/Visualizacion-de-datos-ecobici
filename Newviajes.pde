class Viaje {
  Punto punto_inicio;
  Punto punto_final;

  int x; // posicion actual
  int y; // posicion actual

  String tiempo_inicio ;
  String tiempo_final;
  
  int colora; 
  
  int hora;
  int minuto;

  boolean dibujando;

  String hora_inicio;
  String hora_llegada;

  int minutosviaje;
  //cuantos cuadros por segundo tiene que moverse
  int proporcion_x;
  int proporcion_y;

  public Viaje(Punto p_i, Punto p_f, String t_i, String t_f, int colora) {
    punto_inicio = p_i;
    punto_final = p_f;
    tiempo_inicio = t_i;
    tiempo_final = t_f;
    x = punto_inicio.x;
    y = punto_inicio.y;
    dibujando = false;
    
    this.colora = colora;

    calculartiempo();
    calculardistancia();
    calcularproporcion();
  }

  public boolean mover(int h, int m) {
    if (minutosviaje == 0) {
      return false;
    }
    else {
      if (h == hora && m == minuto) {
        dibujando = true;
      }

      if (dibujando) {
        this.x = x + proporcion_x;
        this.y = y + proporcion_y;
        minutosviaje--;
        return true;
      }
      else {
        return false;
      }
    }
  }

  public void calculartiempo() {
    String[] fecha = split(tiempo_inicio, " ");
    hora_inicio = fecha[1];
    //println(hora_inicio);
    String[] hora_i = split(fecha[1], ":");
    hora =  Integer.parseInt(hora_i[0]);
    minuto =  Integer.parseInt(hora_i[1]);


    String[] fecha2 = split(tiempo_final, " ");
    hora_llegada = fecha2[1];
    String[] hora_l = split(fecha2[1], ":");

    //println(hora_i[0] + ", " + hora_l[0]);
    minutosviaje = ( ( Integer.parseInt(hora_l[0]) - Integer.parseInt(hora_i[0]) ) * 60 ) + ( Integer.parseInt(hora_l[1]) - Integer.parseInt(hora_i[1]));
    //println("Viaje de " + minutosviaje + " minutos");
  }

  public void calculardistancia() {
    proporcion_x = punto_final.x - punto_inicio.x;
    proporcion_y = punto_final.y - punto_inicio.y;
  }

  public void calcularproporcion() {
    if (minutosviaje == 0) {
      proporcion_x = 0;
      proporcion_y = 0;
    }
    else {
      proporcion_x = (int) proporcion_x / minutosviaje;
      proporcion_y = (int) proporcion_y / minutosviaje;
      //println("proporcion x: " + proporcion_x + ", y: " + proporcion_y);
    }
  }
}


class Punto {
  public int x;
  public int y;

  public Punto(int x, int y) {
    this.x = parseInt(x);
    this.y = parseInt(y);
  }
}

