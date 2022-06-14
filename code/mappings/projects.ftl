<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/raw_files/projects.json')>
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

data:Project_[=jpath.filter('$.projectId', dataset)]
    a facility:Project ;
    facility:hasProjectId '[=jpath.filter('$.projectId', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    facility:hasStartDate '[=jpath.filter('$.startDate', dataset)]'^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
    facility:isLocatedIn data:Project_Point_[=jpath.filter('$.projectId', dataset)] .

data:Project_Point_[=jpath.filter('$.projectId', dataset)]
    a geo:Point ;
    geo:lat [=jpath.filter('$.coordsOrigin[0]', dataset)] ;
    geo:lon [=jpath.filter('$.coordsOrigin[1]', dataset)] .

data:TagGroup_[=jpath.filter('$.groups[*].groupId', dataset)]
    a resource:TrackingTagGroup ;
    a resource:EquipmentTagGroup ;
    a resource:ResourceType ;
    resource:name '[=jpath.filter('$.groups[*].groupName', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    resource:resourceTypeId '[=jpath.filter('$.groups[*].groupId', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    resource:belongsToProject data:Project_[=jpath.filter('$.projectId', dataset)] .

<#list jpath.filter('$.groups[*].tags[*]',dataset)>
<#items as tag>
data:TrackingTag_[=jpath.filter('$.tagId',tag)]
    a resource:Resource ;
    a resource:TrackingTag ;
    a resource:EquipmentTag ;
    resource:resourceId '[=jpath.filter('$.tagId',tag)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    <#if jpath.filter('$.tagActive',tag) == "1">
    resource:status "Active"^^<http://www.w3.org/2001/XMLSchema#string> ;
    <#else>
    resource:status "Inactive"^^<http://www.w3.org/2001/XMLSchema#string> ;
    </#if>
    resource:belongsToGroup data:TagGroup_[=jpath.filter('$.groups[*].groupId', dataset)] ;
    resource:belongsToProject data:Project_[=jpath.filter('$.projectId', dataset)] .

</#items>
</#list> 