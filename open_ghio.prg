LOCAL lcCurrentPath

lcCurrentPath = alltrim(sys(5) + sys(2003))

SET DEFAULT TO lcCurrentPath + "\siscom_ghio"
SET EXCLUSIVE OFF
SET DATE FRENCH
SET CENTURY ON
* DO thor
MODIFY PROJECT siscom_ghio
