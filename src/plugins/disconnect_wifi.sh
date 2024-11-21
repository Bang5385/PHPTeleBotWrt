#!/bin/bash

# Nhận MAC Address từ tham số đầu vào
DEVICE_MAC=$1
INTERFACE1="phy0-ap0"
INTERFACE2="phy1-ap0"

# Ngắt kết nối thiết bị trên interface thứ nhất
result1=$(ubus call hostapd.$INTERFACE1 del_client "{ \"addr\": \"$DEVICE_MAC\", \"reason\": 5, \"deauth\": true, \"ban_time\": 300 }" 2>&1)

# Ngắt kết nối thiết bị trên interface thứ hai
result2=$(ubus call hostapd.$INTERFACE2 del_client "{ \"addr\": \"$DEVICE_MAC\", \"reason\": 5, \"deauth\": true, \"ban_time\": 300 }" 2>&1)

# Kiểm tra kết quả và trả về
if [[ -z "$result1" && -z "$result2" ]]; then
    echo "Đã ngắt kết nối thiết bị với MAC: $DEVICE_MAC trên cả hai interface ($INTERFACE1 và $INTERFACE2)."
else
    echo "Kết quả trên $INTERFACE1: $result1"
    echo "Kết quả trên $INTERFACE2: $result2"
fi

