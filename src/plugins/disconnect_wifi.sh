#!/bin/bash

# Kiểm tra xem có tham số MAC không
if [ -z "$1" ]; then
  echo "Vui lòng cung cấp địa chỉ MAC."
  exit 1
fi

MAC=$1
INTERFACE1="phy0-ap0"
INTERFACE2="phy1-ap0"
# Kiểm tra nếu interface có hỗ trợ lệnh iw dev
if ! iw dev $INTERFACE station dump > /dev/null 2>&1; then
  echo "Không tìm thấy giao diện Wi-Fi $INTERFACE."
  exit 1
fi

# Kiểm tra xem địa chỉ MAC có đang kết nối không
CONNECTED_MAC=$(iw dev $INTERFACE station dump | grep "Station" | awk '{print $2}' | grep -i "$MAC")

if [ "$CONNECTED_MAC" == "$MAC" ]; then
    # Ngắt kết nối
    iw dev $INTERFACE1 disconnect
    iw dev $INTERFACE2 disconnect
    echo "Đã ngắt kết nối thiết bị với MAC $MAC khỏi Wi-Fi."
else
    echo "Không tìm thấy thiết bị với MAC $MAC đang kết nối."
    exit 1
fi
