import streamlit as st
import time
from googletrans import Translator

def translate_text(text, target_language):
    translator = Translator()
    translation = translator.translate(text, dest=target_language)
    return translation.text

st.set_page_config(page_title="Farm Financer", page_icon="🚜")
language = st.selectbox("Select Language:", ["English", "Hindi"])

def localized_text(english_text, hindi_text):
    if language == "English":
        return english_text
    elif language == "Hindi":
        return translate_text(english_text, target_language="hi")



st.title(localized_text("Farm Financer Tutorial", "फार्म फाइनेंसर ट्यूटोरियल"))
st.header(localized_text("Welcome to our app!", "हमारे एप्लिकेशन में आपका स्वागत है!"))

st.write("Farm Financer is a tool designed to help farmers manage their finances efficiently.")
st.write("In this tutorial, we'll guide you through the features and how to use them.")


st.header("How to Use Our App")

st.subheader("Features")
st.write("You can add informational text cards like this to provide context or instructions.")

st.subheader("2. Images")
st.write("You can also include images to illustrate your content.")
st.image("https://via.placeholder.com/150", caption="Example Image")

st.subheader("3. Animations")
st.write("We've included some cool animations to make your tutorial engaging.")
st.text("Simple text animation:")
with st.empty():
    for i in range(1, 6):
        st.write("Loading" + "." * i)
        time.sleep(0.5)

st.text("Spinner animation:")
with st.spinner("Please wait..."):
    time.sleep(3)
    st.success("Done!")

st.header(localized_text("Conclusion", "निष्कर्ष"))
st.write(localized_text("That's it for our tutorial. We hope this helps you get started with Farm Financer.",
                        "हमारे ट्यूटोरियल के लिए बस इतना ही है। हम आशा करते हैं कि यह आपको फार्म फाइनेंसर का आरंभ करने में मदद करेगा।"))


