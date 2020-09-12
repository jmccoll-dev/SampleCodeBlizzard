#!/bin/bash

#update.bash
#user input
echo ""
echo "You have selected update option!"
echo ""
echo "Item number: (four digit unsigned integer)"
read item_number
echo ""
check_number=${item_number}.item

#check if file exists
if [ ! -e data/$check_number ]; then
    echo "ERROR: item $item_number not found"
    exit 1
    fi

#more user input
echo "Item name: (string containing no whitespace)"
read item_updated
echo ""

echo "Simple name: (string)"
read name_updated
echo ""

echo "Unit price: (floating point number)"
read price_updated
echo ""

echo "Current quantity: (unsigned integer)"
read currQuantity_updated
echo ""

echo "Maximum quantity: (unsigned integer)"
read maxQuantity_updated
echo ""

echo "Description: (string)"
read desc_updated
echo ""

#read and update if needed
while read old_item old_name; do
    read old_price old_qty oldm_qty
    read old_desc

    if [ ! -z "$item_updated" ]; then
        item="$item_updated"
        else
            item="$old_item"
    fi

    if [ ! -z "$name_updated" ]; then
        name="$name_updated"
        else
            name="$old_name"
    fi

    if [ ! -z "$price_updated" ]; then
        price="$price_updated"
        else
            price="$old_price"
        fi
    
    if [ ! -z "$currQuantity_updated" ]; then
        curq="$currQuantity_updated"
        else
            curq="$old_qty"
    fi

    if [ ! -z "$maxQuantity_updated" ]; then
        maxq="$maxQuantity_updated"
        else
            maxq="$oldm_qty"
    fi

    if [ ! -z "$desc_updated" ]; then
        desc="$desc_updated"
        else
            desc="$old_desc"
    fi

#fill and update item file
#Update queries.log
    first="${item} ${name}"
    second="${price} ${curq} ${maxq}"
    third="${desc}"
    echo $first > $check_number
    echo $second >> $check_number
    echo -e $third >> $check_number
    mv ${check_number} data/
    date=`date "+[%Y-%M-%d %H:%m:%S]"`
    echo "$date UPDATED: ${item_number} - ${item} - ${curq} / ${maxq}" >> data/queries.log 
done < data/$check_number
