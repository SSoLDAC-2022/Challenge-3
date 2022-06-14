<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/raw_files/trackedzones.json')>

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix data: <https://data.cogito.iot.linkeddata.es/resources/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix facility: <https://cogito.iot.linkeddata.es/def/facility#> .
@prefix process: <https://cogito.iot.linkeddata.es/def/process#> .
@prefix resource: <https://cogito.iot.linkeddata.es/def/resource#> .
@prefix const: <https://cogito.iot.linkeddata.es/def/construction#> .
@prefix time: <http://www.w3.org/2006/time#> .
@prefix bot:   <https://w3id.org/bot#> .
@prefix geo: <http://www.w3.org/2003/01/geo/wgs84_pos#> .
@prefix s4city: <https://saref.etsi.org/saref4city#> .
@prefix saref: <https://saref.etsi.org/core#> .
@prefix props: <https://w3id.org/props#> .


data:Project_[=jpath.filter('$.*.assignedProjectId', dataset)]
    a facility:Project ;
    facility:hasProjectId '[=jpath.filter('$.*.assignedProjectId', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> .

data:TrackedZone_[=jpath.filter('$.*.zoneId', dataset)]
    a facility:Element ;
    a bot:Element ;
    a facility:Polygon ;
    props:hasCompressedGuid '[=jpath.filter('$.*.zoneId', dataset)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    facility:hasBoundaries data:Polyline_[=jpath.filter('$.*.zoneId', dataset)] .

data:Polyline_[=jpath.filter('$.*.zoneId', dataset)]
    a facility:Polyline ;
    <#list jpath.filter('$.*.boundaries[*]',dataset)>
    <#items as boundary>
    <#if boundary?index==0>
        facility:hasFirstPoint data:Polyline_Point_[=boundary?index].
    </#if>

data:Polyline_Point_[=boundary?index] 
    a facility:Polyline_Point ;
    <#list jpath.filter('$.*.boundaries[*]',dataset) as nextPoint>
    <#if nextPoint?index gt boundary?index>
    facility:hasNextPoint data:Polyline_Point_[=nextPoint?index] ;
    </#if>
    <#if nextPoint?index == boundary?index && nextPoint?is_last>
    facility:hasDirectNextPoint data:Polyline_Point_0 ;
    <#elseif nextPoint?index == boundary?index && !nextPoint?is_last>
    facility:hasDirectNextPoint data:Polyline_Point_[=nextPoint?index+1] ;
    </#if>
    </#list>
    facility:isLocatedIn data:Point_[=boundary?index].
    

data:Point_[=boundary?index]
    a resource:Point ;
    <#list jpath.filter('$.*',boundary)>
    <#items as parameters>
    <#if parameters?is_first>
    facility:hasXCoordinate [=parameters] ;
    <#else>
    facility:hasYCoordinate [=parameters] .

    </#if>
    </#items>
    </#list>
    </#items>
    </#list>