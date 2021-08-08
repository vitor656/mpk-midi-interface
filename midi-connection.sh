#!/bin/bash

MPK_PORT=$(aconnect -i -o | grep \'MPKmini2\' | cut -d ' ' -f 2 | tr -d ':'i)
MIDI_INTERFACE_ADAPTER=$(aconnect -i -o | grep \'UM-ONE\' | cut -d ' ' -f 2 | tr -d ':')
DEVICES_FOUND="N"
DEVICES_CONNECTION=

echo $MPK_PORT
echo $MIDI_INTERFACE_ADAPTER

if [ -z "$MPK_PORT" ]
then
	echo "Dispositivo MPK não encontrado"
else
	echo "Dispositivo MPK encontrado" 
	if [ -z "$MIDI_INTERFACE_ADAPTER" ]
	then
		echo "Interface Midi não encontrada"
	else
		DEVICES_FOUND="S"
		echo "$DEVICES_FOUND - Dispositivos encontrados"
	fi
fi

if [ $DEVICES_FOUND = "S" ]
then
	echo "Connecting To: $MIDI_INTERFACE_ADAPTER"
	DEVICES_CONNECTION=$(aconnect -l | grep "Connecting To: $MIDI_INTERFACE_ADAPTER")
	if [ -n "$DEVICES_CONNECTION" ]
	then
		echo "Dispositivos conectados."
	else
		$(echo aconnect $MPK_PORT:0 $MIDI_INTERFACE_ADAPTER:0) 	
		echo "Efetuando conexão"
	fi	
else
	echo "Dispositivos não encontrados para tentar conexão"
fi
