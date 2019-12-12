from flask import *
from flask_cors import *
import json
import requests
from requests.exceptions import HTTPError
app = Flask(__name__)
cors= CORS(app)
@app.route("/")
def hello():
        return "Frontend Working"


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')