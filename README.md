# KingCal
KingCal Delphi Calendar Component - Open Source Edition


KingCalendar Components for Delphi
Release v2.0 06/28/2018

INTRODUCTION

KingCalendar is a calendar component for Delphi developed by Mark Lussier and
his company AppVision. The component originated originated in Delphi 1.x, then 
was updated to Delphi 2.x and 3.x. 

As Mark moved on from active development, the components became abandoned.
Lance Rasmussen from CDE Software in Seattle has actively updated the component
to the newer Delphi versions and in June 2018, received the permission from Mark
to move the component set to open source and place in source control.

The initial distribution will be for Delphi 10.2 Tokyo. Later, older IDE's will
be added. 

If you wish to contribute source code improvements, please contact Lance Rasmussen
with the source changes.


INSTALLING KINGCALENDAR

Delphi 10.2 Tokyo Instructions

1. Using GitHub, download the project to the desired folder or download the ZIP 
   archive and extract to the desired folder.
2. Open the IDE and go to Tools > Options > Delphi Options > Library
3. For 32 bit - Add the LIB25x32\RELEASE directory (or LIB25x32\DEBUG) to the Library Path
4. For 64 bit - Add the LIB25x64\RELEASE directory (or LIB25x64\DEBUG) to the Library Path
5. Add the SOURCE directory to the Browsing path. Close the Options.
6. Open the KingCalD102All.groupproj project group.
7. Change the Release of the runtime package to 32 bit and to either Release or Debug mode depending on
   your preference based in step 1.
8. Compile the non-DCL package.
9. Change the Release of the designtime package to 32 bit and to either Release or Debug mode depending on
   your preference based in step 1.
10. Compile the designtime package.
11. Right-click on the designtime package and select install.
12. Change the Release of the runtime package to 64 bit and to either Release or Debug mode depending on
   your preference based in step 1.
13. Compile the runtime package.

REMOVING KINGCALENDAR

Delphi 10.2 Tokyo Instructions
 
To un-install the KingCalendar Components from the Delphi IDE perform the
following steps.

1. Use Options |Install Components... Select KINGCAL from the list box on the
   left.. Clik the Remove Button.. Click Ok.
2. Remove the KingCal directory.

UPDATES

The project and updates are currently maintained in Github at:
https://github.com/K7LER/KingCal

SUPPORT

There is no official support of the component. If you have questions or wish to contribute
code updates, please contact Lance Rasmussen at lancerasmussen@gmail.com



