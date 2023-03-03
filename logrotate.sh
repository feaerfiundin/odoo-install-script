#!/bin/bash
# ------------------------------------------------------
# Logrotate installation section
# ------------------------------------------------------
echo -e "Install logrotate"

    #--------------------------------------------------
    # Install Libraries needed for let's encrypt
    #--------------------------------------------------
    sudo apt-get install -y logrotate

cat <<EOF > /etc/logrotate.d/odoo
#Path odoo logs
    $OE_LOG_PATH/*.log {
        rotate 90
        daily
        compress
        dateext
        delaycompress
        missingok
        notifempty
        postrotate
            service odoo-$OE_VERSION-server restart
        endscript
        create 640 odoo adm
    }

EOF
