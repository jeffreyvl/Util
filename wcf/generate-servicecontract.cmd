@REM Generating service contract for webservice
svcutil.exe ^
/sc ^
/useSerializerForFaults ^
/serializer:XmlSerializer ^
/serializable /out:Reference.cs ^
/namespace:*,Stub.Contracts ^
schema\*