#!/bin/bash
#######################################################
# Version: 01b                                        #
#######################################################

zenoss restart

array=( PySamba*.egg WindowsMonitor*.egg ActiveDirectory*.egg IISMonitor*.egg MSExchange*.egg MSMQMonitor*.egg MSSQLServer*.egg ApacheMonitor*.egg DellMonitor*.egg DigMonitor*.egg DnsMonitor*.egg FtpMonitor*.egg HPMonitor*.egg HttpMonitor*.egg IRCDMonitor*.egg JabberMonitor*.egg LDAPMonitor*.egg MySqlMonitor*.egg NNTPMonitor*.egg NtpMonitor*.egg ZenJMX*.egg LinuxMonitor*.egg ZenossVirtualHostMonitor*.egg EsxTop*.egg XenMonitor*.egg DeviceSearch*.egg PythonCollector*.egg WBEM*.egg )
for i in "${array[@]}"
do
	zenpack --install /tmp/opt/zenoss/packs/ZenPacks.zenoss.$i
done

easy_install readline

echo "...Script complete, you may now proceed to run the Build Deb script"
exit 0
