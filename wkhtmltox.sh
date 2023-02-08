#--------------------------------------------------
# Install Wkhtmltopdf if needed
#--------------------------------------------------

INSTALL_WKHTMLTOPDF_VERSION=`wkhtmltopdf --version`
if [ -z "$INSTALL_WKHTMLTOPDF_VERSION" ];then
    
    if [ $INSTALL_WKHTMLTOPDF = "True" ]; then
        echo -e "\n---- Install wkhtml and place shortcuts on correct place for ODOO $OE_VERSION ----"

        OS_RELEASE=`lsb_release -sc`

        if ["$uname -m"=="aarch64"]; then
            _url=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.6-1."$OS_RELEASE"_arm64.deb
        elif [ "`getconf LONG_BIT`" == "64" ];then
            _url=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.6-1."$OS_RELEASE"_amd64.deb
        else
            _url=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.6-1."$OS_RELEASE"_i386.deb
        fi
        wget $_url
        sudo dpkg -i `basename $_url`
        sudo apt-get install -f -y
    else
        echo "Wkhtmltopdf isn't installed due to the choice of the user!"
    fi
else
    echo -e "\n---- wkhtml as alredy installed in $INSTALL_WKHTMLTOPDF_VERSION version"
fi