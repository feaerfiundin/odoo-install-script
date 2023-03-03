#!/bin/bash

source conf.sh
OE_HOME=/opt/odoo

OE_OCA_ADDONS=$OE_SRC/git/OCA-addons

mkdir -p $OE_OCA_ADDONS
cd $OE_OCA_ADDONS


git clone --depth 1 --branch $OE_VERSION https://github.com/JayVora-SerpentCS/Jasperreports_odoo.git 
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/account-financial-reporting.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/account-financial-tools.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/account-payment.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/account-reconcile.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/community-data-files.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/contract.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/crm.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/dms.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/edi.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/field-service.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/helpdesk.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/hr.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/l10n-italy.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/mis-builder.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/partner-contact.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/product-attribute.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/queue.git 
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/report-print-send.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/reporting-engine.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/server-auth.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/server-env.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/server-tools.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/server-ux.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/social.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/stock-logistics-warehouse.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/stock-logistics-barcode.git
git clone --depth 1 --branch $OE_VERSION https://github.com/OCA/web.git


dir=$(find . -maxdepth 1 -type d )

source $OE_INSTANCES/venv/bin/activate

for i in $dir ;
do 
    if [ -f "$i/requirements.txt" ]; then
        echo -e "installate requirements per $i"
        pip3 install -r $i/requirements.txt
    fi
done 