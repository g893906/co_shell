#!/bin/sh -e

sudo modprobe -r gsi_pci_plug
sudo modprobe gsi_pci_plug
sudo /usr/local/bin/dialog-menu
