from pymongo import MongoClient
from pymongo.errors import ConnectionFailure, ServerSelectionTimeoutError
import os
import logging
from datetime import datetime
from pathlib import Path
from typing import Optional
import time

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

MAX_RETRIES = 3
RETRY_DELAY = 2  # seconds
CONNECTION_TIMEOUT = 5000  # milliseconds

def get_connection_string(file_path: Path) -> Optional[str]:
    try:
        if not file_path.exists():
            raise FileNotFoundError(f"Connection string file not found at: {file_path}")
        
        with open(file_path, 'r') as file:
            return file.read().strip()
    except Exception as e:
        logger.error(f"Error reading connection string: {str(e)}")
        return None

def test_database_connection(retry_count: int = 0) -> bool:
    try:
        project_root = Path(__file__).parents[2]
        connection_string = get_connection_string(project_root / 'connection_string.txt')
        
        if not connection_string:
            return False

        # Initialize client with timeout
        client = MongoClient(connection_string, serverSelectionTimeoutMS=CONNECTION_TIMEOUT)
        
        # Test server connection
        client.server_info()
        
        # Test database connection
        db = client['visitordb']
        collection = db['visitors']

        # Test write operation
        test_doc = {
            "id": "test_connection",
            "timestamp": datetime.utcnow().isoformat(),
            "status": "testing"
        }
        
        # Insert test document
        insert_result = collection.insert_one(test_doc)
        logger.info(f"Test document inserted with ID: {insert_result.inserted_id}")

        # Read test document
        read_result = collection.find_one({"id": "test_connection"})
        logger.info(f"Test document retrieved: {read_result}")

        # Clean up test document
        delete_result = collection.delete_one({"id": "test_connection"})
        logger.info(f"Test document deleted: {delete_result.deleted_count} document(s)")

        logger.info("✅ Database connection test successful!")
        return True

    except (ConnectionFailure, ServerSelectionTimeoutError) as e:
        if retry_count < MAX_RETRIES:
            logger.warning(f"Connection attempt {retry_count + 1} failed, retrying in {RETRY_DELAY} seconds...")
            time.sleep(RETRY_DELAY)
            return test_database_connection(retry_count + 1)
        logger.error(f"Failed to connect after {MAX_RETRIES} attempts: {str(e)}")
        return False
        
    except Exception as e:
        logger.error(f"❌ Database connection test failed: {str(e)}")
        return False

    finally:
        if 'client' in locals():
            client.close()
            logger.info("Database connection closed")

if __name__ == "__main__":
    success = test_database_connection()
    exit(0 if success else 1)