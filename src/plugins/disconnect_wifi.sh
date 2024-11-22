#!/bin/bash

# Nhận địa chỉ MAC từ tham số đầu vào
MAC=$1

# Kiểm tra nếu MAC không trống
if [ -z "$MAC" ]; then
    echo -e "Không có địa chỉ MAC"
    exit 1
fi

# Ngắt kết nối thiết bị khỏi Wi-Fi
iw dev $INTERFACE1 station del $MAC
iw dev $INTERFACE2 station del $MAC

echo -e "Đã ngắt kết nối thiết bị với MAC $MAC khỏi Wi-Fi"
