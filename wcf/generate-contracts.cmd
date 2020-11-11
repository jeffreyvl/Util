SET LOCATION=%1
SET NS=%LOCATION:\=.%
svcutil.exe /useSerializerForFaults /serializer:XmlSerializer /serializable /out:%LOCATION%\Reference.cs /config:%LOCATION%\Output.config /namespace:*,Klantbeeld.Contracts.%NS% %LOCATION%\Schema\*
svcutil.exe /sc /useSerializerForFaults /serializer:XmlSerializer /serializable /out:%LOCATION%\ServiceContract\Contract.cs /namespace:*,Klantbeeld.Contracts.%NS%.ServiceContract %LOCATION%\Schema\*