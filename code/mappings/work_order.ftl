<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/raw_files/work_order.json')>

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

<#list jpath.filter('$.*', dataset)>
<#items as work_order>

data:Project_[=jpath.filter('$.ProjectID', work_order)]
    a facility:Project ;
    facility:isRelatedToProcess data:Process_[=jpath.filter('$.ProjectID', work_order)]_[=jpath.filter('$.ProcessID', work_order)] ;
    facility:involvesResource data:TrackingTag_[=jpath.filter('$.ResourceID', work_order)] ;
    facility:hasProjectId '[=jpath.filter('$.ProjectID', work_order)]'^^<http://www.w3.org/2001/XMLSchema#string> .

data:Process_[=jpath.filter('$.ProjectID', work_order)]_[=jpath.filter('$.ProcessID', work_order)]
    a process:Process ;
    process:processId '[=jpath.filter('$.ProcessID', work_order)]'^^<http://www.w3.org/2001/XMLSchema#string> .

data:TrackingTag_[=jpath.filter('$.ResourceID', work_order)]
    a resource:Resource ;
    a resource:TrackingTag ;
    a resource:EquipmentTag ;
    facility:isUsedIn data:Project_[=jpath.filter('$.ProjectID', work_order)] ;
    resource:resourceId '[=jpath.filter('$.ResourceID',work_order)]'^^<http://www.w3.org/2001/XMLSchema#string> .

data:WorkOrder_[=jpath.filter('$.WorkOrderID', work_order)]
    a process:WorkOrder ;
    process:workOrderId '[=jpath.filter('$.WorkOrderID', work_order)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    process:belongsToProcess data:Process_[=jpath.filter('$.ProjectID', work_order)]_[=jpath.filter('$.ProcessID', work_order)] ;
    resource:hasAssignedResource data:TrackingTag_[=jpath.filter('$.ResourceID', work_order)] .

</#items>
</#list>