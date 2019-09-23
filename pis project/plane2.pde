int i, j,Score,Score2; 

float flight;
float flight2;
float Angle;
float Angle2;
float DistancePlaneBird;
float DistancePlaneBird2;
int DistanceUltra;
int IncomingDistance;
int DistanceUltra2;
int IncomingDistance2;

float BirdX;
float BirdY;


String DataIn;
String DataIn2;

float [] CloudX = new float[6];
float [] CloudY = new float[6];

PImage Cloud;
PImage Bird;

import processing.sound.*;
SoundFile file;
  //put your audio file name here
  String audioName = "sample3.mp3";
  String path;
  
import processing.serial.*; 
Serial myPort;    
Serial myPort2;


  void setup(){ 
    path = sketchPath(audioName);
    file = new SoundFile(this, path);
    file.play();
    
    myPort = new Serial(this, Serial.list()[0], 9600); 
    myPort2 = new Serial(this, Serial.list()[1], 9600); 

    myPort.bufferUntil(10);  
    myPort2.bufferUntil(10); 
    
    frameRate(30); 
    Score = 0;
    Score2 = 0;

    size(1800, 800);
    rectMode(CORNERS) ; 
    noCursor(); 
    textSize(16);
    flight = 200; 
    flight2 = 100;

    Cloud = loadImage("cloud.png");  
    Bird = loadImage("bird3.png");  

    //int clouds position
    for  (int i = 1; i <= 5; i = i+1) {
        CloudX[i]=random(3000);
        CloudY[i]=random(3000);
    }
}


void serialEvent(Serial p) { 
   if (p == myPort){
       DataIn = p.readString(); 
   
        IncomingDistance = int(trim(DataIn)); //conversion from string to integer
        println(IncomingDistance); 
        if ( IncomingDistance>1  && IncomingDistance<100 ) {
        DistanceUltra = IncomingDistance; }     
   }
    
   if(p == myPort2){
      DataIn2 = p.readString(); 
      IncomingDistance2 = int(trim(DataIn2)); //conversion from string to integer
      println(IncomingDistance2); //checks....
            if(IncomingDistance2!=1){
                  IncomingDistance=0;            
            }}
   
}

void draw() 
{
    background(0, 0, 0);
    sky();
          //Angle2 = mouseY-500;           
    DistancePlaneBird = sqrt(pow((400-BirdX), 2) + pow((flight-BirdY), 2)) ;
    if (DistancePlaneBird < 50) {
       Score = Score + 1;
    }
   
   
    DistancePlaneBird2 = sqrt(pow((400-BirdX), 2) + pow((flight2-BirdY), 2)) ;
    if (DistancePlaneBird2 < 50) {
       Score2 = Score2 + 1;  
    }

    textSize(30);
    text("Score:", 80, 30); 
    text( Score, 180, 30);
    
    text("Score2: ", 230, 30); 
    text( Score2, 330, 30); 
    
    
    Angle = (18- DistanceUltra)*6;  // play with sensor
    
    if(IncomingDistance2 == 1){
        Angle2 = (sin(radians(45)))*20;
     }
     else{
        Angle2 = sin(radians(-45))*20;
     }
    
    flight = flight + sin(radians(Angle))*10; 
    flight2 = flight2 + Angle2;
    
    if (flight < 0) {
        flight=0;
    }
    
    if (flight2 < 0) {
        flight2=10;
    }
   
    if (flight > 800) {
        flight=800;
    }
    
    if (flight2 > 800) {
        flight2=700;
    }

    TraceAvion(flight, Angle);
    TraceAvion2(flight2,Angle2);
    
    BirdX =   BirdX -  cos(radians(Angle))*10;

    if (BirdX < -30) {
        BirdX=900;
        BirdY = random(600);
    }

    //draw and move the clouds
    for  (int i = 1; i <= 5; i = i+1) {
        CloudX[i] =   CloudX[i] -  cos(radians(Angle))*(10+2*i);

        image(Cloud, CloudX[i], CloudY[i], 300, 500);

        if (CloudX[i] < -300) {
            CloudX[i]=1000;
            CloudY[i] = random(400);
        }
    }
     
    scale(3.0);
    image(Bird, BirdX, BirdY, 100, 80); 
}


void sky() {
    noStroke();
    rectMode(CORNERS);

    for  (int i = 1; i < 1500; i = i+10) {
        fill( 30   +i*0.165, 100  +i*0.144, 150  + i*0.075   );
        rect(0, i, 1800, i+10);
    }
}


void TraceAvion(float Y, float AngleInclinaison) {
    noStroke();
    pushMatrix();
    translate(400, Y);
    rotate(radians(AngleInclinaison));  
    
    scale(0.7); 
    fill(255, 0, 0);
    stroke(0, 0, 0);
    strokeWeight(10);
    ellipse(292-228, 151-85, 45, 45);

    line(373-228, 145-85, 373-228, 20-85); 

    strokeWeight(10); //borders of plane

    beginShape();
    vertex(214, 120);
    vertex(32, 82);
    vertex(32, 76 );
    vertex(15, 71);
    vertex(35, 69);
    vertex(35, 21);
    vertex(49, 21);
    vertex(57, 24);
    vertex(70, 30);
    vertex(79, 43);
    vertex(81, 58);
    vertex(95, 68);
    vertex(161, 62);
    vertex(187, 59);
    vertex(239, 59);
    vertex(242, 42);
    vertex(296, 40);
    vertex(297, 58);
    vertex(351, 59);
    vertex(365, 67);
    vertex(373, 82);
    vertex(364, 98);
    vertex(339, 109);
    vertex(305, 118);
    vertex(273, 133);

    translate(-228, -85); 
    endShape(CLOSE);
    fill(0, 0, 0);
    fill(255, 128, 0);
    popMatrix();
}

void TraceAvion2(float Y, float AngleInclinaison) {
    noStroke();
    pushMatrix();
    translate(400, Y);
    rotate(radians(AngleInclinaison)); 
    scale(0.7);  
    fill(0, 255, 0);
    stroke(0, 0, 0);
    strokeWeight(10);
    ellipse(292-228, 151-85, 45, 45); 

    line(373-228, 145-85, 373-228, 20-85); 

    strokeWeight(10); 

    beginShape();
    vertex(214, 120);
    vertex(32, 82);
    vertex(32, 76 );
    vertex(15, 71);
    vertex(35, 69);
    vertex(35, 21);
    vertex(49, 21);
    vertex(57, 24);
    vertex(70, 30);
    vertex(79, 43);
    vertex(81, 58);
    vertex(95, 68);
    vertex(161, 62);
    vertex(187, 59);
    vertex(239, 59);
    vertex(242, 42);
    vertex(296, 40);
    vertex(297, 58);
    vertex(351, 59);
    vertex(365, 67);
    vertex(339, 109);
    vertex(305, 118);
    vertex(273, 133);

    translate(-228, -85); 
    endShape(CLOSE);

    fill(0, 0, 0);
    fill(255, 128, 0);
    popMatrix();
}
