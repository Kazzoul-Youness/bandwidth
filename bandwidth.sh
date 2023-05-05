#!/bin/bash

# Spécifiez la version SNMP, la chaîne de communauté et l'index d'interface.
# Specify the SNMP version, community string, and interface index
SNMP_VERSION="2c"
SNMP_COMMUNITY="public"
IF_INDEX="2"  # numéro de l'interface 

#  Obtenir la valeur initiale de ifInOctets et de ifOutOctets
# Get the initial value of ifInOctets and ifOutOctets
IN_OCTETS=$(snmpwalk -v $SNMP_VERSION -c $SNMP_COMMUNITY localhost IF-MIB::ifInOctets.$IF_INDEX | awk '{print $NF}')
OUT_OCTETS=$(snmpwalk -v $SNMP_VERSION -c $SNMP_COMMUNITY localhost IF-MIB::ifOutOctets.$IF_INDEX | awk '{print $NF}')

# Sleep for  5 min
sleep 300

# Obtenir la nouvelle valeur de ifInOctets et ifOutOctets
# Get the new value of ifInOctets and ifOutOctets
NEW_IN_OCTETS=$(snmpwalk -v $SNMP_VERSION -c $SNMP_COMMUNITY localhost IF-MIB::ifInOctets.$IF_INDEX | awk '{print $NF}')
NEW_OUT_OCTETS=$(snmpwalk -v $SNMP_VERSION -c $SNMP_COMMUNITY localhost IF-MIB::ifOutOctets.$IF_INDEX | awk '{print $NF}')

# Calculer l'utilisation de la bande passante en bits par seconde
# Calculate the bandwidth usage in bits per second
IN_BPS=$((($NEW_IN_OCTETS - $IN_OCTETS) * 8))
OUT_BPS=$((($NEW_OUT_OCTETS - $OUT_OCTETS) * 8))

echo "Interface bandwidth usage: In: $IN_BPS bps, Out: $OUT_BPS bps"
