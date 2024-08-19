#!/bin/bash

# درخواست آدرس DNS از کاربر
read -p "لطفا آدرس DNS خود را وارد کنید: " dns_address

# بررسی DNS با استفاده از dig
echo "در حال بررسی آدرس DNS..."
dig_output=$(dig @$dns_address google.com)

# نمایش نتایج
if echo "$dig_output" | grep -q "ANSWER SECTION"; then
    echo "آدرس DNS معتبر است."
    # استخراج اطلاعات از dig_output
    response_time=$(echo "$dig_output" | grep "Query time" | awk '{print $4}')
    server_ip=$(echo "$dig_output" | grep "SERVER:" | awk '{print $2}')
    echo "زمان پاسخ‌دهی: ${response_time} ms"
    echo "آدرس آی‌پی سرور: ${server_ip}"
else
    echo "آدرس DNS نامعتبر است یا مشکلی در ارتباط وجود دارد."
fi
