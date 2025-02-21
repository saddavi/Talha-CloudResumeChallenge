from pymongo import MongoClient
import os
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def initialize_counter():
    try:
        # Get connection string
        connection_string = os.environ.get('COSMOS_CONNECTION_STRING')
        if not connection_string:
            raise ValueError("COSMOS_CONNECTION_STRING not set")

        # Initialize MongoDB client
        client = MongoClient(connection_string)
        db = client['visitordb']
        collection = db['visitors']

        # Counter document
        counter_doc = {
            "id": "visitor_count",
            "count": 0,
            "lastUpdated": datetime.utcnow().isoformat()
        }

        # Upsert the counter document
        result = collection.update_one(
            {"id": "visitor_count"},
            {"$setOnInsert": counter_doc},
            upsert=True
        )

        logger.info(f"Counter initialization successful. Modified: {result.modified_count}")
        return True

    except Exception as e:
        logger.error(f"Error initializing counter: {str(e)}")
        raise

if __name__ == "__main__":
    initialize_counter()