<#assign xpath=handlers('XmlHandler')>
<#assign dataset=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/raw_files/schedule.xml')>
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
@prefix cost: <http://data.cogito.iot.linkeddata.es/resources/cost/> .
@prefix interval: <http://data.cogito.iot.linkeddata.es/resources/interval/> .

data:Project_[=xpath.filter('./Project/Final_Project_ID/text()', dataset)]
    a facility:Project ;
    facility:isRelatedToProcess data:[=xpath.filter('./Project/GUID/text()', dataset)] .
data:Process_[=xpath.filter('./Project/Final_Project_ID/text()', dataset)]_[=xpath.filter('./Project/GUID/text()', dataset)]
    a process:Process ;
    process:processID '[=xpath.filter('./Project/GUID/text()', dataset)]' ;
    process:hasName '[=xpath.filter('./Project/Name/text()', dataset)]' ;
    process:hasCreationDate '[=xpath.filter('./Project/CreationDate/text()', dataset)]'^^<http://www.w3.org/2001/XMLSchema#dateTime>;
    process:hasCost cost:[=xpath.filter('./Project/GUID/text()', dataset)] ;
    process:isPlannedIn interval:[=xpath.filter('./Project/GUID/text()', dataset)] .
<#list xpath.filter('./Project/Tasks/Task[*]',dataset)>
<#items as task>
data:Task_[=xpath.filter('./Project/Final_Project_ID/text()', dataset)]_[=xpath.filter('./Project/GUID/text()', dataset)]_[=xpath.filter('./Task/UID/text()', task)]
    a process:Task ;
    process:taskId '[=xpath.filter('./Task/GUID/text()', task)]' ;
    process:taskUid '[=xpath.filter('./Task/UID/text()', task)]' ;
    process:hasName '[=xpath.filter('./Task/Name/text()', task)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    process:hasCreationDate '[=xpath.filter('./Task/CreationDate/text()', task)]'^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
    process:isPlannedIn interval:[=xpath.filter('./Task/GUID/text()', task)] ;
    process:hasPriority '[=xpath.filter('./Task/Priority/text()', task)]'^^<http://www.w3.org/2001/XMLSchema#integer> ;
    process:hasProgress '[=xpath.filter('./Task/RemainingWork/text()', task)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    process:hasStatus '[=xpath.filter('./Task/ActualWork/text()', task)]'^^<http://www.w3.org/2001/XMLSchema#string> ;
    process:hasCost cost:[=xpath.filter('./Task/GUID/text()', task)] <#if xpath.filter('./Task/Childs',task)?trim != '' || xpath.filter('./Task/Parent_WBS',task)?trim != ''>;<#else>.</#if>
    <#if xpath.filter('./Task/Childs',task)?trim != ''>
        process:hasSubTask
        <#assign childs = xpath.filter("./Task/Childs/WBS/text()",task)>
        <#if childs?is_sequence>
            <#list childs as child>
                '[=child]'^^<http://www.w3.org/2001/XMLSchema#string> <#if child?is_last && xpath.filter('./Task/Parent_WBS',task)?trim == ''> . <#elseif child?is_last && xpath.filter('./Task/Parent_WBS',task)?trim != ''> ; <#else> , </#if>
            </#list>
        <#else>
             '[=childs]'^^<http://www.w3.org/2001/XMLSchema#string> <#if xpath.filter('./Task/Parent_WBS',task)?trim == ''> . <#else> ; </#if>
        </#if>
    </#if>
    <#if xpath.filter('./Task/Parent_WBS',task)?trim != ''>
        process:isSubTaskOf '[=xpath.filter('./Task/Parent_WBS/text()', task)]'^^<http://www.w3.org/2001/XMLSchema#string> .
    </#if>
</#items>
</#list>