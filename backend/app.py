from flask import Flask, jsonify, request
from flask_cors import CORS
from werkzeug.security import safe_str_cmp
from functools import wraps
import requests
import os

from utils.system_info import get_system_info
from utils.security_checks import get_open_ports, get_running_processes, get_failed_logins
from config import Config

app = Flask(__name__)
CORS(app)

# === Basic Auth Decorator === #
def require_basic_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth = request.authorization
        if not auth or not check_auth(auth.username, auth.password):
            return jsonify({"message": "Authentication required."}), 401, {
                "WWW-Authenticate": 'Basic realm="Login Required"'
            }
        return f(*args, **kwargs)
    return decorated

def check_auth(username, password):
    return (safe_str_cmp(username, Config.BASIC_AUTH_USERNAME) and 
            safe_str_cmp(password, Config.BASIC_AUTH_PASSWORD))

# === Slack Notification Helper === #
def send_slack_notification(text):
    if Config.SLACK_WEBHOOK_URL:
        payload = {"text": text}
        try:
            requests.post(Config.SLACK_WEBHOOK_URL, json=payload)
        except Exception as e:
            print(f"Failed to send Slack notification: {e}")

@app.route("/")
def home():
    return jsonify({"message": "Linux Security Dashboard API is running"})

@app.route("/api/system-info", methods=["GET"])
@require_basic_auth
def system_info():
    data = get_system_info()
    return jsonify(data)

@app.route("/api/open-ports", methods=["GET"])
@require_basic_auth
def open_ports():
    data = get_open_ports()
    return jsonify(data)

@app.route("/api/processes", methods=["GET"])
@require_basic_auth
def processes():
    data = get_running_processes()
    return jsonify(data)

@app.route("/api/failed-logins", methods=["GET"])
@require_basic_auth
def failed_logins():
    data = get_failed_logins()
    # إرسال تنبيه إلى Slack عند وجود محاولات فاشلة
    if isinstance(data, list) and len(data) > 0:
        send_slack_notification(f"Detected {len(data)} failed login attempts!")
    return jsonify(data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
