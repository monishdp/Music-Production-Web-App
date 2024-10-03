# AI Music Production Web App

This project is an AI-assisted music production web application that generates lyrics based on user input. It uses Flutter for the frontend and a Python Flask backend with Hugging Face's API for lyric generation.

## Prerequisites

- Flutter SDK (2.0.0 or later)
- Python 3.7 or later
- Git
- A Hugging Face account and API token

## Setup

1. Clone the repository:
   ```
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. Set up the Python backend:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   pip install -r requirements.txt
   ```

3. Create a `.env` file in the root directory and add your Hugging Face API token:
   ```
   HUGGINGFACE_API_TOKEN=your_token_here
   ```

4. Set up the Flutter frontend:
   ```
   flutter pub get
   ```

## Running the Application Locally

1. Start the Flask backend:
   ```
   python app.py
   ```
   The backend will run on `http://127.0.0.1:5000/`

2. In a new terminal, run the Flutter web app:
   ```
   flutter run -d chrome
   ```
   This will open the app in a new Chrome window.

## Using the Application

1. In the web interface, you'll see three main sections:
   - Language: Enter the language for the lyrics
   - Genre: Enter the genre of the song
   - Lyrics: This section has two text areas and a button
     - In the first text area, describe the song you want to produce
     - Click "Create/Update Lyrics" to generate lyrics
     - The generated lyrics will appear in the second text area

2. Fill in all fields and click "Create/Update Lyrics" to generate your song lyrics.

## Deployment

To deploy this application:

1. Deploy the Flask backend to Vercel:
   - Install Vercel CLI: `npm install -g vercel`
   - Run `vercel` in the project root and follow the prompts
   - Set the `HUGGINGFACE_API_TOKEN` in Vercel's environment variables

2. Update the API URL in the Flutter app (`lib/main.dart`) to point to your Vercel-deployed backend.

3. Build the Flutter web app:
   ```
   flutter build web
   ```

4. Deploy the contents of the `build/web` directory to a static hosting service of your choice (e.g., Vercel, Firebase Hosting, GitHub Pages).

## Troubleshooting

- If you encounter CORS issues, ensure that your Flask backend has CORS properly configured.
- If the lyrics generation fails, check your Hugging Face API token and ensure you haven't exceeded the rate limits.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).