<#assign jpath=handlers("JsonHandler")>
<#assign dataset=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/simulation_trajectory.json')>
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
<#list jpath.filter('$.tagdata', dataset) as tagdata>
<#--  if tagId == tagId ...  -->
data:TrackingTag_[=jpath.filter('$.tagId', tagdata)]
    a resource:Resource ;
    a resource:TrackingTag ;
    a resource:EquipmentTag ;
    facility:isUsedIn data:Project_[=jpath.filter('$.assignedProjectId', tagdata)] ;
    resource:resourceId '[=jpath.filter('$.tagId',tagdata)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    resource:lastTimePressed '[=jpath.filter('$.lastSeen',tagdata)]'^^<http://www.w3.org/2001/XMLSchema#time> ;
    resource:locationRadius [=jpath.filter('$.locationRadius',tagdata)] ;
    resource:inferredAccuracy [=jpath.filter('$.locationRadius',tagdata)] ;
    resource:inferredMovement [=jpath.filter('$.locationRadius',tagdata)] ;
    resource:inferredSpeed [=jpath.filter('$.locationRadius',tagdata)] ;
    resource:batteryStatus [=jpath.filter('$.locationRadius',tagdata)] ;
    resource:hasTrajectory data:Trajectory_[=jpath.filter('$.tagId', tagdata)] .

<#if tagdata?index==0>
data:Trajectory_[=jpath.filter('$.tagId', tagdata)]
    a resource:Trajectory ;
    facility:hasFirstPoint facility:Traject_Point_[=tagdata?index].
</#if>

facility:Traject_Point_[=tagdata?index]
    a facility:Trajectory ;
    <#list jpath.filter('$.tagdata',dataset) as nextPoint>
    <#if nextPoint?index gt tagdata?index>
    facility:hasNextPoint facility:Traject_Point_[=nextPoint?index] ;
    </#if>
    <#if nextPoint?index == tagdata?index && nextPoint?is_last>
    facility:hasDirectNextPoint data:Point_0 ;
    <#elseif nextPoint?index == tagdata?index && !nextPoint?is_last>
    facility:hasDirectNextPoint data:Point_[=nextPoint?index+1] ;
    </#if>
    </#list>
    facility:isLocatedIn data:Point_[=tagdata?index] .

facility:Point_[=tagdata?index]
    a resource:Point ;
    a geo:Point ;
    <#list jpath.filter('$.xy_location', tagdata) as points>
    <#if points?is_first>
    facility:hasXCoordinate '[=points]'^^<http://www.w3.org/2001/XMLSchema#float> ;
    <#else>
    facility:hasYCoordinate '[=points]'^^<http://www.w3.org/2001/XMLSchema#float> ;
    </#if>
    </#list>
    <#list jpath.filter('$.coordLocation', tagdata) as points>
    <#if points?is_first>
    geo:lat '[=points]'^^<http://www.w3.org/2001/XMLSchema#float> ;
    <#else>
    geo:long '[=points]'^^<http://www.w3.org/2001/XMLSchema#float> .
    </#if>
    </#list>
</#list>