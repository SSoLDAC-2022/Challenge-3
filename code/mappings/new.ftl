<#assign jpath=handlers("JsonHandler")>
<#assign dataset0=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory0.json')>

<#assign dataset1=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory1.json')>

<#assign dataset2=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory2.json')>

<#assign dataset3=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory3.json')>

<#assign dataset4=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory4.json')>

<#assign dataset5=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory5.json')>

<#assign dataset6=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory6.json')>

<#assign dataset7=providers(type='FileProvider', file='/Users/salva/Dropbox/cogito/summer_school/trajectory_files/real_time_trajectory7.json')>



<#list jpath.filter('$.tagdata', dataset0) + jpath.filter('$.tagdata', dataset1) + jpath.filter('$.tagdata', dataset2) + jpath.filter('$.tagdata', dataset3) + jpath.filter('$.tagdata', dataset4) + jpath.filter('$.tagdata', dataset5) + jpath.filter('$.tagdata', dataset6) + jpath.filter('$.tagdata', dataset7) as tagdata>
<#list jpath.filter('$.tagbuttons', dataset0) + jpath.filter('$.tagbuttons', dataset1) + jpath.filter('$.tagbuttons', dataset2) + jpath.filter('$.tagbuttons', dataset3) + jpath.filter('$.tagbuttons', dataset4) + jpath.filter('$.tagbuttons', dataset5) + jpath.filter('$.tagbuttons', dataset6) + jpath.filter('$.tagbuttons', dataset7) as tagbuttons>
<#assign previousValue=jpath.filter('$.lastPressed', tagbuttons)>
<#if jpath.filter('$.lastPressed', tagbuttons)==previousValue && !tagbutton?is_last &&tagbutton?is_first>
First 
[=jpath.filter('$.lastPressed', tagbuttons)]
<#elseif jpath.filter('$.lastPressed', tagbuttons)==previousValue && !tagbutton?is_last &&!tagbutton?is_first>
[=jpath.filter('$.lastPressed', tagbuttons)]
<#elseif jpath.filter('$.lastPressed', tagbuttons)!=previousValue && !tagbutton?is_last >
[=jpath.filter('$.lastPressed', tagbuttons)]
</#if>


</#list>
</#list>