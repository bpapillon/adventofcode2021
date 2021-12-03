#!/bin/bash

INPUT_FILE="inputs/03/01.txt"

# assume all binary strings in the file are the same length, but we need to figure out what that length is
firstLine=$(head -n 1 $INPUT_FILE)
strLen=${#firstLine}

# build decimal representation of gamma value as we move through the binary string by position
gammaDecimal=0
sigmaDecimal=0
for i in $(seq 1 $strLen)
do
  # get the most frequent bit at position i, convert to a decimal value, and increment the gamma decimal
  bit=$(cut -c $i $INPUT_FILE | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}')
  gammaDecimal=$(($gammaDecimal+(2**($strLen-$i))*$bit))

  # we can assume sigma is a binary inverse of gamma, so flip the bit and increment the sigma decimal the same way
  bit=$((bit ^= 1))
  sigmaDecimal=$(($sigmaDecimal+(2**($strLen-$i))*$bit))
done

echo $(($gammaDecimal*$sigmaDecimal))
