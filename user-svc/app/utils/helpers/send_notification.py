from firebase_admin import messaging
from firebase_admin import credentials
from logger import logger
async def send_notification(title: str, body: str, token: str):
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        token=token,
    )
    response = messaging.send(message)
    logger.success(response)
