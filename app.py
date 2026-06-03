from flask import Flask, render_template, request
import mysql.connector
import os

app = Flask(__name__)

DB_CONFIG = {
    "host": os.environ.get("DB_HOST", "localhost"),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", ""),
    "database": os.environ.get("DB_NAME", "elite_estates_db")
}

def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)

@app.route('/')
def index():
    db = get_db_connection()
    cur = db.cursor(dictionary=True)

    cur.execute(""" SELECT properties.*, agents.name 
                FROM properties
                LEFT JOIN agents ON agents.id = properties.agent_id
                WHERE properties.status = 'active' AND properties.featured = 1
                ORDER BY properties.created at DESC LIMIT 3 """)
    
    featured_properties = cur.fetchall()
    cur.execute("SELECT COUNT(*) as cnt FROM  properties WHERE status = 'active'")
    stats = cur.fetchone()
    cur.close()
    db.close()
    return render_template('index.html', featured_properties=featured_properties, stats=stats)

if __name__ == '__main__':
    app.run(debug=True)