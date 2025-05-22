int fsrPin = 0;     // the FSR and 10K pulldown are connected to a0
int fsrReading;     // the analog reading from the FSR resistor divider
int V = 5;
#include "DHT.h"
#define DHT_PIN 3 // The Arduino Nano pin connected to DHT22 sensor
#define DHT_TYPE DHT22
float O2=0;
DHT dht22(DHT_PIN, DHT_TYPE);

#include <Wire.h>
#include "MAX30100_PulseOximeter.h"

#define REPORTING_PERIOD_MS     2000

// PulseOximeter is the higher level interface to the sensor
// it offers:
//  * beat detection reporting
//  * heart rate calculation
//  * SpO2 (oxidation level) calculation
PulseOximeter pox;

uint32_t tsLastReport = 0;

// Callback (registered below) fired when a pulse is detected
void onBeatDetected()
{
    Serial.println("Beat!");
}

void setup()
{
  pinMode(V, OUTPUT);
Serial.begin(115200);
   
delay(500);
    Serial.println("Initializing MAX30100");
    // Initialize the PulseOximeter instance and register a beat-detected callback
    pox.begin();
    pox.setOnBeatDetectedCallback(onBeatDetected);

    dht22.begin(); // initialize the sensor
}

void loop()
{

// Make sure to call update as fast as possible
      pox.update();

    // Asynchronously dump heart rate and oxidation levels to the serial
    // For both, a value of 0 means "invalid"

    O2=pox.getSpO2()+3;
    if (millis() - tsLastReport > REPORTING_PERIOD_MS) {
        Serial.print("Heart rate:");
        Serial.print(pox.getHeartRate());
        Serial.print("bpm / SpO2:");
        Serial.print(O2);
        Serial.print("% / temp:");
        Serial.print(pox.getTemperature());
        Serial.println("C");

        tsLastReport = millis();
    }


  
// read humidity
  float humi  = dht22.readHumidity();
  // read temperature as Celsius
  float temperature_C = dht22.readTemperature();
  // read temperature as Fahrenheit

  float temperature_F = dht22.readTemperature(true);

  // check if any reads failed
  if (isnan(humi) || isnan(temperature_C) || isnan(temperature_F)) {
    Serial.println("Failed to read from DHT sensor!");
  } 
  else {
    Serial.print("Humidity: ");
    Serial.print(humi);
    Serial.print("%");

    Serial.print("  |  "); 

    Serial.print("Temperature: ");
    Serial.print(temperature_C);
    Serial.print("°C ~ ");
  }
  
fsrReading = analogRead(fsrPin);  
 
  Serial.print("Force Reading = ");
  Serial.print(fsrReading);     // print the raw analog reading
 
  if (fsrReading < 10) {
    Serial.println(" - No pressure");
  } else if (fsrReading < 200) {
    Serial.println(" - Light touch");
  } else if (fsrReading < 500) {
    Serial.println(" - Light squeeze");
  } else if (fsrReading < 800) {
    Serial.println(" - Medium squeeze");
  } else {
    Serial.println(" - Big squeeze");
  }

  if(humi>60 || O2<97){
    digitalWrite(V,HIGH);
  }
  else{
    digitalWrite(V,LOW);
  }
}
