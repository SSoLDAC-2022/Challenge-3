## IFC.ttl
​
Contains the IFC file format information in turtle format.
​
## resources.csv
​
Contains the information of resources types (e.g., type of workers, machinery, ...) used in the project in CSV format.
​
## schedule.csv
​
Contains the information of the schedule in XML format.
​
​
## To access to the API of trajectories information:
​
Base URI: https://ssoldac2022ch3.mocklab.io
​
| Method |             Headers            |    Endpoint   |                          Description                          |
|:------:|:------------------------------:|:-------------:|:-------------------------------------------------------------:|
|   GET  | Content-Type: application/json |   /projects   |                    Get projects in progress                   |
|   GET  | Content-Type: application/json |   /taggroups  |                Retrieve the groups of the tags                |
|   GET  | Content-Type: application/json |  /tagbuttons  |               Retrieve when a button is pressed               |
|   GET  | Content-Type: application/json |    /tagdata   |              Retrieve the information of the tag              |
|   GET  | Content-Type: application/json | /trackedzones | Retrieve the information about the zone that is being tracked |
​
## simulation.py
​
Executes a simulation of positions at the places where the workers are at the moment and retrieves a json with the same information as the endpoint /tagdata of the previous API table. To install the required libraries execute the following command:
​
```
pip3 install -r requirements.txt
```
​
To execute the script execute the following command:
​
```
python3 simulation.py
```
