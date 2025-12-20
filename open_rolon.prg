LOCAL lcCurrentPath

lcCurrentPath = alltrim(sys(5) + sys(2003))

SET DEFAULT TO lcCurrentPath + "\linfow_gestion_rolon"
SET EXCLUSIVE OFF
SET DATE FRENCH
SET CENTURY ON
* DO thor
MODIFY PROJECT lg-rolon
