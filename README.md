# What is the Smart Foot Pad?

it is a shoe insole that can monitor the shoe environment and alert diabetic foot patiencts of a critical state occuring.
the insole work by monitoring the temperature, oxygenation, humidity of the shoe, and depending on a threshold it will alert the patient via buzzing sound and a notification comming from an associate mobile application.

the insole is invented using multiple sensors integrated into arduino uno and connected to a mobile application vua bluetooth.

The risk factor (foot state) is calculated through an invented formula that normalizes the values of temperature, humidity, oxygenation to be "+-1", where 1 is the threshold.

# Features
    1- Monitor foot state via bluetooth (temperature, pressure, humidity).
    2- history of the recorded state in daily bases.
    3- daily pedometer.
    4- local notifications for critical states.
    5- Multiple state stages (good, bad, very bad, critical).

# Used Technologies and Packages
    1- Flutter as the framework.
    2- bluetooth classic for mobile connection.
    3- Hive NoSQL DB for history storage.
    4- riverpod for statemanagement.

# General overview

![image](https://github.com/user-attachments/assets/ce205c92-ea23-41a7-b58d-c96c47d303db)
![image](https://github.com/user-attachments/assets/0a1e895d-0bf2-44ef-a703-bf70e0e13e45)
![image](https://github.com/user-attachments/assets/ffdee14f-79ce-4c9f-96e5-7e64f3c95b64)


# A well organized report
this is a report that demonstrate the used technologies and parts with the theory behind the project in a structured manner
[Report.pdf](https://github.com/user-attachments/files/20454958/Report.pdf)
