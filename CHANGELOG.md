
## 2015-04-28

* fixed label not being reset on `/we cancel` if no selection was made. This was resulted after the update 0.5.6.7, which fixed possible invalid selection in the marking selector API.
* All commands involving a marking selector now have a `-p` (i.e. "preserve") flag to preserve the current marking selector status object (if one exists).