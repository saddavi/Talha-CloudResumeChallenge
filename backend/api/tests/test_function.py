import unittest
import azure.functions as func
from ..VisitorCounter import main
import os
import json

class TestFunction(unittest.TestCase):
    def setUp(self):
        # Setup test environment
        os.environ["COSMOS_CONNECTION_STRING"] = "your_test_connection_string"
    
    def test_counter_increment(self):
        # Construct HTTP request
        req = func.HttpRequest(
            method='GET',
            body=None,
            url='/api/counter',
            params={}
        )
        
        # Execute function
        response = main(req)
        
        # Assert response
        self.assertEqual(response.status_code, 200)
        self.assertIn("Visitor count:", response.get_body().decode())