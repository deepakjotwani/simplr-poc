from flask import *
from flask_cors import *
import json
import requests
from requests.exceptions import HTTPError
app = Flask(__name__)
cors= CORS(app)
@app.route("/backend")
def hello():
        return "Backend Working"
@app.route("/")
def test():
        return "Backend Working"


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')