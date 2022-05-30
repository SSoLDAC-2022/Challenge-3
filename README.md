# Challenge-3:  Integration of trajectory-based data into 4D BIM Semantic Digital Twin

**Champions**: Andrea Cimmino,  Dimitrios, Maria Poveda Villalón, Kyriakos, Raul García Castro

**Number of people per team**: 3-4
**Anticipated workload**: about 20-25 hours per person, which includes time for preparation of the presentation.

## Challenge description: 
During the last year, the European COGITO project has successfully generated the Knowledge Graph of a Digital Twin containing heterogeneous construction and process data (Katsigarakis et al.), i.e., 4D BIM, integrating data sources like IFC, working schedules, resources (e.g., people or machinery involved in the construction), location data, etc. 
These data bring value to static aspects of the construction, like the building elements, nevertheless, other dynamic aspects are not yet contemplated; like how an external stimulus affects or modifies the building elements. Trajectory data brings value to the construction in both the building phase and during its usage when concluded. For instance, during the construction being aware of the trajectories of people, vehicles, or even heavy-weight materials can avoid collisions increasing the overall safety and decreasing the risks associated. 
The challenge is to integrate data of trajectories into the context of a 4D BIM Knowledge Graph representing a Semantic Digital Twin used to simulate construction processes. This problem can be solved by extending an existing ontology of this domain with a module for expressing trajectories, and then, generating the Knowledge Graph that also includes trajectories. For this challenge, the data provided belongs to a railway station under construction and the trajectories of its workers.
An additional aspect of this challenge is the exploitation of the Knowledge Graph data. This problem can be solved using SPARQL queries, e.g., who is passing nearby a specific column at this specific time? or, which is the most repeated trajectory?. Another approach for addressing this problem is relying on visualizing and generating simulations. In this second part of the challenge, novel approaches for exploiting the data within the generated Knowledge Graph are required, using SPARQL queries, visualization tools, or simulations.

Within the coding challenge you will work on the following tasks:
* Ontology developing: use the 4D BIM COGITO ontology, i.e. https://cogito.iot.linkeddata.es/, and develop a suitable extension for modelling trajectories. 
* Data semantization: develop the necessary translation mappings for generating RDF data from the different data sources
* Data queries: develop some SPARQL queries to genearte value from the data from the Knowledge Graph
* Data visualisation: explore visualisation and/or simulation tools for the RDF in oreder to extract value from the construction and trajectory data. For instance, 3D models, real-time simulation of walkers, etc..

## Challenger Research Questions:
* What are the challenges of trajectory data in terms of ontology modelling and integration with existing 4D BIM ontologies?
* How RDF data of constructions can be visualised using an SPARQL endpoint and how it can be used for adding value to the construction sector?
* How simulations for constructions can be generated using RDF data? 

## Data Sets available: 
* [API for trajectory data](https://ssoldac2022ch3.mocklab.io/)

* [4D BIM data from COGITO h2020 project (IFC, XML, CSV, and JSON)]()

## Challenge Instructions
Bring your laptop.

## Tools
* Helio
* Virtuoso
* Google Refine
* 2D simulation tools (e.g., Unity)

## References
1. Cimmino, A., & García-Castro, R.(2022). Helio: a framework for implementing the life cycle of knowledge graphs.Semantic Web Journal.
2. Katsigarakis, K. and  N.Lilis, G. and Rovas, D. González-Gerpe, S. and Bernardos, S. and Cimmino, A. and Poveda-Villalón, M. and García-Castro, R. (2022). A Digital Twin Platform generating Knowledge Graphs for construction projects. SeDIT Workshop.
