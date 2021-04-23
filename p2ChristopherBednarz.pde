import controlP5.*;
import java.util.TimerTask;
import java.util.Timer;

PFont ErasITCB;
PFont Bahn;

final int BACKC = #1B1D1F;
final int BACKFILL = 100;
final int BACKFILL2 = #675833;
final int BACKFILL3 = #742828;
final int FRONTFILL = 255;
final int FRONTFILL2 = #FFF1AD;
final int FRONTFILL3 = #FFBAAF;
final int LINEFILL = 180;
final int LINEFILL2 = #FFB300;
final int LINEFILL3 = #FF0000;

public int time = millis();


public static class Variables {
  public static int rpm = 7500;
  public static int speed = 0;
  public static int fuel = 50;
  public static int out_temp = 75;
  public static int eng_temp = 90;
  public static int boost = -10;
  public static char gear = 'N';

  public static String unit = "mph";

  public static boolean leftsig = true;
  public static boolean rightsig = true;
  public static boolean emergencysig = true;

  public static boolean lefton = false;
  public static boolean righton = false;
  public static boolean emergencyon = false;

}



//warnings

 
void setup() { 
  size(1600, 800);
  ErasITCB = createFont("eras-bold-itc.ttf", 150);
  Bahn = createFont("bahnschrift.ttf", 64);
  thread( "updater" );
}
 
void draw( ) { 
  background(BACKC); 
                                                                                         //Tachometer
                                                                  
  noStroke();
  noFill();
  
  fill(BACKFILL3);
  rect(375, 500, 800, 190);
  fill(BACKFILL2);
  rect(375, 500, 700, 190);
  fill(BACKFILL);
  rect(375, 500, 500, 190); 

  int displayrpm = (Variables.rpm/100);

  if(Variables.rpm >= 8000){
  fill(FRONTFILL3);
  rect(375, 500, 800, 190);
  fill(FRONTFILL2);
  rect(375, 500, 700, 190);
  fill(FRONTFILL);
  rect(375, 500, 500, 190); 
  }
  
  else if(Variables.rpm >= 7000){
  fill(FRONTFILL3);
  rect(375, 500, 10+(displayrpm*10), 190);
  fill(FRONTFILL2);
  rect(375, 500, 700, 190);
  fill(FRONTFILL);
  rect(375, 500, 500, 190); 
  }

  else if (Variables.rpm >= 5000){
  fill(FRONTFILL2);
  rect(375, 500, 10+(displayrpm*10), 190);
  fill(FRONTFILL);
  rect(375, 500, 500, 190); 
  }
 
  else{
  fill(FRONTFILL);
  rect(375, 500, 10+(displayrpm*10), 190); 
  }
  
  for(int i = -1; i < (displayrpm/10); i++){
    if(i >= 8){
      fill(LINEFILL3);
      rect((476+(7*100)), 500, 9, 190);
    }
    else if(i >= 6){
      fill(LINEFILL3);
      rect((476+(i*100)), 500, 9, 190);
    }
    else if(i >= 4){
      fill(LINEFILL2);
      rect((476+(i*100)), 500, 9, 190);
    }
    else{
      fill(LINEFILL);
      rect((476+(i*100)), 500, 9, 190);
    }
    
  }
   fill(BACKC);
  for(int i = 0; i < 9; i++){
    rect((385+(i*100)), 660, 40, 50);
    rect((435+(i*100)), 660, 40, 50);
  }
  for(int i = 0; i < 9; i++){
    rect((385+(i*100)), 674, 90, 50);
  }
  rect(375, 685, 870, 30);
  fill(BACKC);
  for(int i = 0; i < 86; i++){
    rect((375+(i*10)), 500, 1, 190);
  }
 
                                                                //Speedometer
  
  noFill();
  stroke(BACKC);
  strokeWeight(140);
  bezier(375, 550, 900, 550, 500, 430, 1200, 430);
  noStroke();
  fill(255);
  textFont(ErasITCB);
  text(Variables.speed, 700, 350);  
  textFont(Bahn);
  textSize(64);
  text(Variables.unit, 850, 400);
  textSize(36);
  for(int i = 0; i < 9; i++){
    text(i, 375+(i*100), 715);
  }
  
                                                                 //Gear
  
  stroke(255);
  strokeWeight(4);
  fill(BACKC);
  quad(400, 525, 480, 525, 505, 425, 425, 425 );
  fill(255);
  textSize(64);
  text(Variables.gear, 430, 500);
  textSize(24);
  text("gear",400, 545);
  
  
                                                                 //Fuel
  
  int fueldisplay = Variables.fuel*2;
  noStroke();
  fill(#6ACCFF);
  rect(1300, (155 + (200-fueldisplay)), 60, fueldisplay);
  fill(255);
  rect(1300, 255, 35, 4);
  rect(1300, 205, 20, 4);
  rect(1300, 305, 20, 4);
  rect(1300, 155, 60, 4);
  rect(1300, 355, 60, 4);
  rect(1300, 155, 4, 200);
  fill(255);
  text("fuel",1300, 380);
  
                                                                 //Eng Temp
  
  float temp_display = (Variables.eng_temp-50)*2.5; 
  fill(#6ACCFF);
  rect(1425, 352-temp_display, 60, 10);
  fill(255);
  rect(1425, 255, 35, 4);
  rect(1425, 155, 60, 4);
  rect(1425, 355, 60, 4);
  rect(1425, 155, 4, 200);
  text("eng. temp",1425, 380);
  fill(#9D211D);
  rect(1429, 159, 56, 20);

                                                                 //Boost
   
  //int boostdisplay = fuel*2;
  noStroke();
  fill(#6ACCFF);
  rect(200, (252-(Variables.boost*5)), 60, 10);
  fill(255);
  rect(200, 255, 35, 4);
  rect(200, 205, 20, 4);
  rect(200, 305, 20, 4);
  rect(200, 155, 60, 4);
  rect(200, 355, 60, 4); 
  rect(200, 230, 10, 4);
  rect(200, 180, 10, 4);
  rect(200, 155, 4, 200);
  fill(255);
  text("boost", 200, 380);
  text("20", 175, 165);
  text("10", 175, 215);
  text("0", 175, 265);
  text("-10", 160, 315);
  text("-20", 160, 365);
   
                                                                //Outside Temp
  fill(150);
  rect(1300, 590, 60, 80 );
  fill(BACKC);
  rect(1302, 592, 56, 76 );
  fill(255);
  text("outside",1300, 700);
  textSize(36);
  text("°F", 1365, 668);
  textSize(48);
  text(Variables.out_temp,1304, 650);
  
    
  int passedMillis = millis() - time;
  
  if(passedMillis >= 500){
    time = millis();
    if(Variables.leftsig && Variables.lefton){
       Variables.lefton = false;
    }
    else if(Variables.leftsig){
      fill(255);
      triangle(650, 100, 720, 70, 720, 130);
      Variables.lefton = true;
    }
    
    if(Variables.rightsig && Variables.righton){
       Variables.righton = false;
    }
    else if(Variables.rightsig){
      fill(255);
      triangle(950, 100, 880, 70, 880, 130);
      Variables.righton = true;
    }
    
    if(Variables.emergencysig && Variables.emergencyon){
       Variables.emergencyon = false;
    }
    else if(Variables.emergencysig){
      fill(255);
      triangle(770, 100, 830, 100, 800, 60);
      Variables.emergencyon = true;
    }
  }
  
  fill(255);
  textSize(24);
  text("warnings go here",100, 700);
  text("(couldn't finish in time)",100, 750);
  
  
  
  
}
 
void updater() {
  while (true) {
    
     }
   
}

void gofast(){
}
