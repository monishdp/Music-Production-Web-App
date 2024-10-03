from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)
CORS(app)

API_URL = "https://api-inference.huggingface.co/models/google/gemma-2-2b-it"
headers = {"Authorization": f"Bearer {os.environ.get('HUGGINGFACE_API_TOKEN')}"}

def query(payload):
    response = requests.post(API_URL, headers=headers, json=payload)
    return response.json()

@app.route('/generate_lyrics', methods=['POST'])
def generate_lyrics():
    try:
        data = request.json
        prompt = data.get('prompt', '')
        language = data.get('language', 'English')
        genre = data.get('genre', 'Pop')

        full_prompt = f"Generate lyrics for a {genre} song in {language}. The song should be about: {prompt}"

        output = query({
            "inputs": full_prompt,
            "parameters": {"max_length": 200}
        })

        # The response format might vary, so we need to handle it appropriately
        if isinstance(output, list) and len(output) > 0:
            lyrics = output[0].get('generated_text', '')
        elif isinstance(output, dict):
            lyrics = output.get('generated_text', '')
        else:
            lyrics = str(output)  # Fallback to string representation

        return jsonify({"lyrics": lyrics})

    except Exception as e:
        print(f"Error generating lyrics: {str(e)}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)