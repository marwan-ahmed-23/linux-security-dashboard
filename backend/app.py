from flask import Flask, jsonify, request
from flask_cors import CORS
from utils.system_info import get_system_info
from utils.security_checks import (
    get_open_ports,
    get_running_processes,
    get_failed_logins
)

app = Flask(__name__)
CORS(app)  

@app.route("/")
def home():
    return jsonify({"message": "Linux Security Dashboard API is running"})

@app.route("/api/system-info", methods=["GET"])
def system_info():
    data = get_system_info()
    return jsonify(data)

@app.route("/api/open-ports", methods=["GET"])
def open_ports():
    data = get_open_ports()
    return jsonify(data)

@app.route("/api/processes", methods=["GET"])
def processes():
    data = get_running_processes()
    return jsonify(data)

@app.route("/api/failed-logins", methods=["GET"])
def failed_logins():
    data = get_failed_logins()
    return jsonify(data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
