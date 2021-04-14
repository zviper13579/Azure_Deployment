#!/bin/bash
grep -i $2 $1_Dealer_schedule | grep -i " "$3 | awk '{print $1,$2,$5,$6}'
