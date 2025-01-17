import os

class Config:
    BASIC_AUTH_USERNAME = os.environ.get("BASIC_AUTH_USERNAME", "admin")
    BASIC_AUTH_PASSWORD = os.environ.get("BASIC_AUTH_PASSWORD", "secret")
    SLACK_WEBHOOK_URL   = os.environ.get("SLACK_WEBHOOK_URL", "")
