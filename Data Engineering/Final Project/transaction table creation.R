colnames(customer) = c('customer_key','customer_id','gender','age','senior_mo','activeness','foreign_citizen','join_channel','gross_house_inc','first_join','segment_id','province_id')
customer$segment_id = as.factor(customer$segment_id)
customer$province_id = as.factor(customer$province_id)
customer$gross_house_inc = as.numeric(customer$gross_house_inc)
Santander_cleaned_python$gross_house_inc = round(Santander_cleaned_python$gross_house_inc)

customer2 = customer
customer2 = customer2[-(7567545:18328819),]
merged = merge(customer2,Santander_cleaned_python, by = c("customer_id", "gender", "age","province_id","segment_id","gross_house_inc","senior_mo","activeness","foreign_citizen"))

customer2$segment_id = as.integer(customer2$segment_id)
customer2$province_id = as.integer(customer2$province_id)
write.csv(customer2, "customer.csv")
write.csv(merged,"merged.csv")
