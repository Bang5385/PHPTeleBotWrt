#!/bin/bash

# Kiểm tra xem có tham số MAC không
if [ -z "$1" ]; then
  echo "Vui lòng cung cấp địa chỉ MAC."
  exit 1
fi

MAC=$1
INTERFACE1="phy0-ap0"
INTERFACE2="phy1-ap0"

# Kiểm tra nếu interface1 có hỗ trợ lệnh iw dev
if ! iw dev $INTERFACE1 station dump > /dev/null 2>&1; then
  echo "Không tìm thấy giao diện Wi-Fi $INTERFACE1."
  exit 1
fi

# Kiểm tra nếu interface2 có hỗ trợ lệnh iw dev
if ! iw dev $INTERFACE2 station dump > /dev/null 2>&1; then
  echo "Không tìm thấy giao diện Wi-Fi $INTERFACE2."
  exit 1
fi

# Kiểm tra xem địa chỉ MAC có đang kết nối không ở cả 2 interface
CONNECTED_MAC1=$(iw dev $INTERFACE1 station dump | grep "Station" | awk '{print $2}' | grep -i "$MAC")
CONNECTED_MAC2=$(iw dev $INTERFACE2 station dump | grep "Station" | awk '{print $2}' | grep -i "$MAC")

if [ "$CONNECTED_MAC1" == "$MAC" ] || [ "$CONNECTED_MAC2" == "$MAC" ]; then
    # Ngắt kết nối
    if [ "$CONNECTED_MAC1" == "$MAC" ]; then
        iw dev $INTERFACE1 disconnect
        echo "Đã ngắt kết nối thiết bị với MAC $MAC khỏi giao diện $INTERFACE1."
    fi
    if [ "$CONNECTED_MAC2" == "$MAC" ]; then
        iw dev $INTERFACE2 disconnect
        echo "Đã ngắt kết nối thiết bị với MAC $MAC khỏi giao diện $INTERFACE2."
    fi
else
    echo "Không tìm thấy thiết bị với MAC $MAC đang kết nối."
    exit 1
fi
