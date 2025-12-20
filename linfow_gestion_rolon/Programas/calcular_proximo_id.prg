PARAMETERS cTabName, cCpoID

LOCAL li_ProxID

li_ProxID = 0

SET DELETED OFF

SELECT MAX(&cCpoID) AS MaxID FROM &cTabName INTO CURSOR cur_Max
SELECT cur_Max
IF ISNULL(cur_Max.MaxID)
	li_ProxID = 1
ELSE
	li_ProxID = cur_Max.MaxID + 1
ENDIF

USE IN cur_Max

SET DELETED ON

RETURN li_ProxID