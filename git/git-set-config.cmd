echo off
shift
shift
git config user.name "name"
git config user.email "mail@email.com"
for /f "tokens=* USEBACKQ" %%f in (`git config --global user.name`) do (SET globalName=%%f)
for /f "tokens=* USEBACKQ" %%f in (`git config --global user.email`) do (SET globalEmail=%%f)
for /f "tokens=* USEBACKQ" %%f in (`git config user.name`) do (SET localName=%%f)
for /f "tokens=* USEBACKQ" %%f in (`git config user.email`) do (SET localEmail=%%f)

echo global: %globalName% %globalEmail%
echo local: %localName% %localEmail%