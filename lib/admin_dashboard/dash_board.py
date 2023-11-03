import streamlit as st
import pandas as pd
import numpy as np
from google.cloud import firestore

st.title('Farmers Market Data')
st.metric(label="Debit", value="₹ 5000", delta="₹ 200")

st.markdown("<h1 style='text-align: center; color: white;'>My Dashboard</h1>", unsafe_allow_html=True)


db = firestore.Client.from_service_account_json("firestore-key.json")


users_ref = db.collection("users")


# Initialize a list to store the retrieved data.
data_list = []
for doc in users_ref.stream():
    data = doc.to_dict()
    data_list.append(data)


sums_saving = 0
field2 = [entry['savings'] for entry in data_list]
for ent in field2:
    sums_saving = sums_saving + ent

# Initialize a list to store all expenses.
all_expenses = []

for user_doc in users_ref.stream():
    user_data = user_doc.to_dict()
    user_id = user_data.get('uid')  # Assuming you have a 'uid' field in your user documents

    # Create a reference to the 'expense' subcollection for the current user.
    expense_collection_ref = users_ref.document(user_id).collection('expense')

    # Iterate through the 'expense' subcollection for the current user.
    user_expenses = []

    for expense_doc in expense_collection_ref.stream():
        expense_data = expense_doc.to_dict()
        user_expenses.append(expense_data)

    # Append the user's expenses to the list of all expenses.
    all_expenses.extend(user_expenses)

# Now, 'all_expenses' contains the expenses for all users.
# You can print or process this data as needed.
exp_data = []
in_data = []
for expense in all_expenses:
    if (expense.get('isIncome') == 'Income'):
        in_data.append(expense)
    else :
        exp_data.append(expense)
    # st.write(expense)
   
    # st.write(in_data)

# st.write(exp_data)
#st.write(in_data)
exp_list = [item["amount"] for item in exp_data]
user_list = [item["id"] for item in exp_data]
sum_inc = 0
sum_exp = 0
ids = 0
for iteam in exp_data:
    sum_exp= sum_exp + iteam["amount"]
for id in exp_data:
    ids = ids + 1
for id in in_data:
    ids = ids + 1
for iteam in in_data:
    sum_inc = sum_inc + iteam["amount"]
 
st.metric(label="Expense", value=sum_exp, delta="-200")
st.metric(label="users" , value=ids, delta="2")
st.metric(label="Income", value=sum_inc, delta="200")
st.metric(label="Savings", value=sums_saving, delta="₹ 7000")
ch_dt = pd.DataFrame(exp_list)
st.area_chart(ch_dt,color="#FFA500")
