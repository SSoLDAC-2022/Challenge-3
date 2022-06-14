<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/raw_files/taggroups.json')>
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix data: <https://data.cogito.iot.linkeddata.es/resources/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix facility: <https://cogito.iot.linkeddata.es/def/facility#> .
@prefix process: <https://cogito.iot.linkeddata.es/def/process#> .
@prefix resource: <https://cogito.iot.linkeddata.es/def/resource#> .
@prefix const: <https://cogito.iot.linkeddata.es/def/construction#> .
@prefix time: <http://www.w3.org/2006/time#> .
@prefix geo: <http://www.w3.org/2003/01/geo/wgs84_pos#> .
@prefix s4city: <https://saref.etsi.org/saref4city#> .
@prefix saref: <https://saref.etsi.org/core#> .

data:Project_[=jpath.filter('$.*.projectId', dataset)]
    a facility:Project ;
    facility:hasProjectId '[=jpath.filter('$.*.projectId', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> .

data:TagGroup_[=jpath.filter('$.*.groupId', dataset)]
    a resource:TrackingTagGroup ;
    a resource:EquipmentTagGroup ;
    a resource:ResourceType ;
    resource:name '[=jpath.filter('$.*.groupName', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    resource:resourceTypeId '[=jpath.filter('$.*.groupResourceType', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    resource:belongsToProject data:Project_[=jpath.filter('$.*.projectId', dataset)] .