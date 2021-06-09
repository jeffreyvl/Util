
SET LOCATION = "WebService/v0101"
SET NS = %LOCATION:\=.%

@REM Generating service contract and clientbase for soap client
svcutil.exe ^
/useSerializerForFaults ^
/serializer:XmlSerializer ^
/serializable ^
/out:%LOCATION%\Reference.cs ^
/config:%LOCATION%\Output.config ^
/namespace:*,Klantbeeld.Contracts.%NS% ^
%LOCATION%\Schema\*

@REM Generating service contract for webservice
svcutil.exe ^
/sc ^
/useSerializerForFaults ^
/serializer:XmlSerializer ^
/serializable ^
/out:%LOCATION%\ServiceContract\Contract.cs ^
/namespace:*,Klantbeeld.Contracts.%NS%.ServiceContract ^
%LOCATION%\Schema\*