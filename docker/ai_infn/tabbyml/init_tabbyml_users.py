#!/usr/bin/env python3
import sqlite3
import os, socket
import time
import logging


def main(token: str = None):
    """Main function to update user authentication token."""

    # Retrieve the username from the hostname
    username = socket.gethostname().split('-')[-1]
    token = token if token is not None else 'ai-infn-rocks'
    logger = logging.getLogger("init_tabbyml")

    path = os.path.expanduser("~/.tabby/ee")
    if not os.path.exists(path):
        os.makedirs(path) # Create directory if it doesn't exist

    while True:  # Infinite loop to ensure database initialization completion
        with sqlite3.connect(os.path.join(path, 'db.sqlite')) as db:
            time.sleep(1)
            tables = db.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall()
            if ('users',) in tables:  # If the users table exists in the database
                break
        print("TabbyML DB is not initialized yet, waiting...")
        time.sleep(1)  # Added sleep to wait before retrying

    logger.info(f"Updating token for user {username} to `{token}`")
    with sqlite3.connect(os.path.join(path, 'db.sqlite')) as db:
        db.execute("INSERT OR REPLACE INTO users(id, email, active, name, auth_token, is_admin, avatar) VALUES (1, 'user@example.com', 1, ?, ?, 1, NULL);", (username, token))
    
    logger.info ("Update complete")  

if __name__ == "__main__":
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument("--token", type=str, default='ai-infn-rocks', help="Token to use for authentication")

    # Set up basic logging configuration with visually appealing format
    log_format = '%(asctime)s:%(levelname)s:%(message)s'
    logging.basicConfig(level=logging.INFO, format=log_format)

    args = parser.parse_args()

    main(args.token)

