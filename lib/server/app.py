from flask import Flask, request, jsonify
from PyPDF2 import PdfReader
from langchain.text_splitter import CharacterTextSplitter
from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.vectorstores import FAISS
from langchain.chains.question_answering import load_qa_chain
from langchain.llms import OpenAI

app = Flask(__name__)
OPENAI_API_KEY="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"

def pdf_content(pdf_docss):
    text = ""
    pdf_reader = PdfReader(pdf_docss)
    for page in pdf_reader.pages:
        text += page.extract_text()
    return text


def process_pdf(pdf_content):
    # Split into chunks
    text_splitter = CharacterTextSplitter(
        separator="\n",
        chunk_size=1000,
        chunk_overlap=200,
        length_function=len
    )
    chunks = text_splitter.split_text(pdf_content)

    # Creating embeddings
    embeddings = OpenAIEmbeddings(openai_api_key="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")
    knowledge_base = FAISS.from_texts(chunks, embeddings)

    return knowledge_base


@app.route('/chatbot', methods=['POST', 'GET'])
def ask_pdf_question():
    if request.method == 'POST':
        user_question = request.json.get('question')


        pdf_docs = r"C:\Users\user\StudioProjects\farm_financer\lib\server\corporate bank.pdf"


        if user_question:
            pdf_contents = pdf_content(pdf_docs)

            # Process the PDF content
            knowledge_base = process_pdf(pdf_contents)
            docs = knowledge_base.similarity_search(user_question)
            llm = OpenAI(openai_api_key=OPENAI_API_KEY)
            chain = load_qa_chain(llm, chain_type="stuff")
            response = chain.run(input_documents=docs, question=user_question)
            print(response)

            return jsonify({'response': response})

    return jsonify({'response': 'No question provided or PDF text extraction failed'})


if __name__ == '__main__':
    app.run(debug=True)