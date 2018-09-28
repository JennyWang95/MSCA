setwd("/Users/Elyse/Documents/UChicago/Courses/Data Engineering Platform/final project/Final project/Santander")

datapath<-'~/Documents/UChicago/Courses/Data Engineering Platform/final Project/Final project/Santander'
Santander.complete<-read.csv(file=paste(datapath,"train_ver2.csv",sep="/"),header=TRUE,sep=",")

colnames(Santander.complete) <- c('date','customer_id','employee_index','country_resi','gender','age','first_join','cus_new','senior_mo','first_primary','primary_last_dt','cus_type','activeness','res_type','foreign_citizen','spouse_employee_index','join_channel','cus_deceased','address_type','province_id','province','cus_active_id','gross_house_inc','cus_segment','prod_savings_acct','prod_guarantees','prod_current_acct','prod_derivada_acct','prod_payroll_acct','prod_junior_acct','prod_mas_particular_acct','prod_particular_acct','prod_particular_plus_acct','prod_short_term_dep','prod_med_term_dep','prod_long_term_dep','prod_e_acct','prod_funds','prod_mrtg','prod_pensions','prod_loans','prod_taxes','prod_credit_card','prod_securities','prod_home_acct','prod_payroll','prod_pension','prod_direct_debit')

library(dplyr)

# since customer code will be the primary key, we cannot have na or blank in it 
Santander.complete.cleaned <- Santander.complete %>% 
  filter(!is.na(customer_id)) %>%
  filter(customer_id != "")

Santander.complete.cleaned %>% 
  group_by(employee_index) %>% 
  summarise(count = n()) # 3rd column should be deleted, 
# there are so little customers that are employee, we can just consider everyone as non-employee

# column 7,8,9 are partially dependent and have similar meanings, among these, column 8 is not useful to our business case, so we can delete it. 
Santander.complete.cleaned %>% 
  group_by(first_primary) %>% 
  summarise(count = n()) # 10th column should be deleted

Santander.complete.cleaned %>% 
  group_by(primary_last_dt) %>% 
  summarise(count = n()) # 11th column should be deleted, 
# but before that we should delete people with 99 and na in first_primary because they are not customers anymore

Santander.complete.cleaned <- Santander.complete.cleaned %>% 
  filter(first_primary != "99") 

Santander.complete.cleaned %>% 
  group_by(cus_type) %>% 
  summarise(count = n())  # column 12
#Customer type at the beginning of the month ,1 (First/Primary customer), 2 (co-owner ),P (Potential),3 (former primary), 4(former co-owner)
# it would make sense to delete 3,4, P and then delete the column, so we can treat current primary customer and co-owner as primary owners

Santander.complete.cleaned <- Santander.complete.cleaned%>% 
  filter(cus_type %in% c("1","1.0","2","2.0"))

Santander.complete.cleaned %>% 
  group_by(res_type) %>% 
  summarise(count = n())  #column 14 should be deleted

Santander.complete.cleaned %>% 
  group_by(activeness) %>% 
  summarise(count = n()) # after cleaning, this column don't have potential or previous customers

Santander.complete.cleaned %>%
  group_by(cus_active_id) %>%
  summarise(count=n())

Santander.complete.cleaned %>%
  group_by(spouse_employee_index) %>%
  summarise(count = n()) # we can delete column 16 and consider people who has spouse
#as employee does not make differences

Santander.complete.cleaned %>% 
  group_by(cus_deceased) %>% 
  summarise(count = n()) # 18th column should be deleted

Santander.complete.cleaned <- Santander.complete.cleaned%>% 
  filter(cus_deceased != "S") # first delete deceased customer

Santander.complete.cleaned %>% 
  group_by(address_type) %>% 
  summarise(count = n())
#based on the result, column 19 should be deleted

Santander.complete.cleaned <- Santander.complete.cleaned[-c(3,8,10,11,12,14, 16,18,19)] # delete first column
# do a check-up of the nas
sort(colSums(is.na(Santander.complete.cleaned)), decreasing=T) # house incoming could be an very 

# importantant predictor, we will delete N.A. later. 
Santander.complete.cleaned <- na.omit(Santander.complete.cleaned)

#take a look at if everyone is in Spain now, if yes we delete the column
Santander.complete.cleaned %>% 
  group_by(country_resi) %>% 
  summarise(count = n())

#it seems necessary to filter out these two people then delete the column 5
Santander.complete.cleaned<- Santander.complete.cleaned[-3]

# do a check-up of the blanks, join channel,and customer segmentation  have some blanks, they are important indictors, we may delete these customers when we do analysis. 
apply(Santander.complete.cleaned[,1:38],2,function(z) sum(z == ""))

Santander.complete.cleaned %>% 
  group_by(activeness) %>% 
  summarise(count = n())

Santander.complete.cleaned %>% 
  group_by(cus_active_id) %>% 
  summarise(count = n()) # suprisingly although they mean the same thing, it does not match. We decided to remove one column


Santander.complete.cleaned <- Santander.complete.cleaned[-12] # delete the cus_active

#Translation
Santander.complete.cleaned$province <- sub("CORUÑA, A", "CORUNA, A", Santander.complete.cleaned$province)

Santander.complete.cleaned$gender <- sub("H", "M", Santander.complete.cleaned$gender)
Santander.complete.cleaned$gender <- sub("V", "F", Santander.complete.cleaned$gender)

Santander.complete.cleaned$foreign_citizen <- sub("S", "Y", Santander.complete.cleaned$foreign_citizen)

write.csv(Santander.complete.cleaned, "Santander.complete.R.cleaned.csv")


