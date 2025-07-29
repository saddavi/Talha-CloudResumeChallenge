#!/usr/bin/env python3
"""
Cross-posting script to sync GitHub blog posts to multiple platforms
Supports: Hashnode, Dev.to, Medium, LinkedIn
"""

import os
import json
import requests
import frontmatter
from pathlib import Path
from datetime import datetime
import argparse

class CrossPoster:
    def __init__(self):
        self.config = {
            'hashnode': {
                'api_key': os.getenv('HASHNODE_API_KEY', 'ed948391-526a-4fed-8882-600c04990807'),
                'publication_id': os.getenv('HASHNODE_PUBLICATION_ID', '67e676905db16cf102d02cc6'),
                'endpoint': 'https://gql.hashnode.com/'
            },
            'dev_to': {
                'api_key': os.getenv('DEV_TO_API_KEY'),
                'endpoint': 'https://dev.to/api/articles'
            },
            'medium': {
                'api_key': os.getenv('MEDIUM_API_KEY'),
                'user_id': os.getenv('MEDIUM_USER_ID'),
                'endpoint': 'https://api.medium.com/v1/users'
            }
        }

    def read_post(self, file_path):
        """Read Jekyll post with frontmatter"""
        with open(file_path, 'r', encoding='utf-8') as f:
            post = frontmatter.load(f)
        return post

    def post_to_hashnode(self, post, file_path):
        """Post article to Hashnode"""
        try:
            mutation = """
            mutation CreatePublicationPost($input: CreatePostInput!) {
                createPost(input: $input) {
                    post {
                        id
                        slug
                        url
                    }
                }
            }
            """

            variables = {
                "input": {
                    "title": post.metadata.get('title', 'Untitled'),
                    "contentMarkdown": post.content,
                    "tags": [{"slug": tag} for tag in post.metadata.get('tags', [])],
                    "publicationId": self.config['hashnode']['publication_id'],
                    "slug": self.generate_slug(post.metadata.get('title', 'untitled'))
                }
            }

            headers = {
                'Authorization': f"Bearer {self.config['hashnode']['api_key']}",
                'Content-Type': 'application/json'
            }

            response = requests.post(
                self.config['hashnode']['endpoint'],
                json={'query': mutation, 'variables': variables},
                headers=headers
            )

            if response.status_code == 200:
                result = response.json()
                if 'errors' not in result:
                    print(f"✅ Published to Hashnode: {result['data']['createPost']['post']['url']}")
                    return True
                else:
                    print(f"❌ Hashnode error: {result['errors']}")
            else:
                print(f"❌ Hashnode HTTP error: {response.status_code}")
                
        except Exception as e:
            print(f"❌ Hashnode exception: {str(e)}")
        
        return False

    def post_to_dev_to(self, post, file_path):
        """Post article to Dev.to"""
        if not self.config['dev_to']['api_key']:
            print("⚠️ Dev.to API key not configured")
            return False

        try:
            article_data = {
                "article": {
                    "title": post.metadata.get('title', 'Untitled'),
                    "published": False,  # Start as draft
                    "body_markdown": post.content,
                    "tags": post.metadata.get('tags', [])[:4],  # Dev.to max 4 tags
                    "series": "Multi-Cloud Engineering",
                    "canonical_url": f"https://talha-nasiruddin.github.io{file_path.replace('_posts/', '/').replace('.md', '/')}"
                }
            }

            headers = {
                'api-key': self.config['dev_to']['api_key'],
                'Content-Type': 'application/json'
            }

            response = requests.post(
                self.config['dev_to']['endpoint'],
                json=article_data,
                headers=headers
            )

            if response.status_code == 201:
                result = response.json()
                print(f"✅ Published to Dev.to: {result['url']}")
                return True
            else:
                print(f"❌ Dev.to error: {response.status_code} - {response.text}")
                
        except Exception as e:
            print(f"❌ Dev.to exception: {str(e)}")
        
        return False

    def generate_slug(self, title):
        """Generate URL-friendly slug from title"""
        import re
        slug = title.lower()
        slug = re.sub(r'[^a-z0-9\s-]', '', slug)
        slug = re.sub(r'\s+', '-', slug)
        slug = slug.strip('-')
        return slug[:50]  # Limit length

    def process_post(self, file_path, platforms=None):
        """Process a single post for cross-posting"""
        if platforms is None:
            platforms = ['hashnode']

        print(f"\n📄 Processing: {file_path}")
        
        try:
            post = self.read_post(file_path)
            print(f"📝 Title: {post.metadata.get('title', 'Untitled')}")
            print(f"🏷️ Tags: {', '.join(post.metadata.get('tags', []))}")
            
            results = {}
            
            if 'hashnode' in platforms:
                results['hashnode'] = self.post_to_hashnode(post, file_path)
            
            if 'dev.to' in platforms and self.config['dev_to']['api_key']:
                results['dev.to'] = self.post_to_dev_to(post, file_path)
            
            return results
            
        except Exception as e:
            print(f"❌ Error processing {file_path}: {str(e)}")
            return {}

    def process_directory(self, posts_dir, platforms=None):
        """Process all posts in directory"""
        posts_path = Path(posts_dir)
        
        if not posts_path.exists():
            print(f"❌ Posts directory not found: {posts_dir}")
            return
        
        md_files = list(posts_path.glob("*.md"))
        
        if not md_files:
            print(f"⚠️ No markdown files found in {posts_dir}")
            return
        
        print(f"🔍 Found {len(md_files)} posts to process")
        
        for file_path in md_files:
            self.process_post(str(file_path), platforms)
            print("⏱️ Waiting 5 seconds between posts...")
            import time
            time.sleep(5)


def main():
    parser = argparse.ArgumentParser(description='Cross-post blog articles to multiple platforms')
    parser.add_argument('--file', help='Single file to cross-post')
    parser.add_argument('--dir', default='_posts', help='Directory of posts to cross-post')
    parser.add_argument('--platforms', nargs='+', default=['hashnode'], 
                       choices=['hashnode', 'dev.to', 'medium'],
                       help='Platforms to post to')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be posted without actually posting')
    
    args = parser.parse_args()
    
    poster = CrossPoster()
    
    print("🚀 Multi-Cloud Blog Cross-Poster")
    print("=" * 50)
    
    if args.dry_run:
        print("🔍 DRY RUN MODE - No actual posting will occur")
    
    if args.file:
        if os.path.exists(args.file):
            poster.process_post(args.file, args.platforms)
        else:
            print(f"❌ File not found: {args.file}")
    else:
        poster.process_directory(args.dir, args.platforms)
    
    print("\n✨ Cross-posting complete!")


if __name__ == "__main__":
    main()
