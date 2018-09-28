import pandas as pd
dat1 = pd.read_csv("/home/hjlee6896/Santander.complete.R.cleaned.csv")
newcol = dat1['cus_segment']
idx = 13
dat1.insert(loc=idx, column='segment_id', value=newcol)
dat1.iloc[:,13:15]
dat1['cus_segment'] = dat1['cus_segment'].str.replace(" ","")
dat1['cus_segment'] = dat1['cus_segment'].str.replace("-","")
dat1['cus_segment'] = dat1['cus_segment'].map(lambda x: str(x)[2:])
dat1.iloc[:,13:15]
dat1['segment_id'] = dat1['segment_id'].str.replace(" ","")
dat1['segment_id'] = dat1['segment_id'].str.replace("-","")
dat1['segment_id'] = dat1['segment_id'].map(lambda x: str(x)[1])
dat1.iloc[:,13:15]
dat = dat1.iloc[:,1:]
dat.to_csv("Santander_cleaned_python.csv",index=False)