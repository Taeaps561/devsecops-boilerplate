from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return {
        "status": "secure",
        "message": "Welcome to the DevSecOps-Hardened Application",
        "version": "1.0.0"
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
