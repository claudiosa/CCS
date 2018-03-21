#!/bin/bash
rsync   -avzrul   --delete Dropbox/ /media/ccs/hd_externo/Dropbox/
rsync   -avzrul   --delete principal/ /media/ccs/hd_externo/principal/
echo "Tudo sincronizado !!!"
