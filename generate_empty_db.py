#!/usr/bin/env python3
"""
Script pour créer une base de données SQLite vide pour les clés d'activation
"""

import sqlite3
import os

def create_empty_database():
    db_path = os.path.join('assets', 'activation_keys.db')
    
    # Supprime l'ancienne base si elle existe
    if os.path.exists(db_path):
        os.remove(db_path)
        print(f"🗑️  Ancienne base supprimée")
    
    # Crée la nouvelle base
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Crée la table
    cursor.execute('''
        CREATE TABLE activation_keys (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key_value TEXT UNIQUE NOT NULL,
            created_at INTEGER NOT NULL
        )
    ''')
    
    # Crée l'index
    cursor.execute('''
        CREATE INDEX idx_key_value ON activation_keys(key_value)
    ''')
    
    conn.commit()
    conn.close()
    
    print(f"✅ Base de données vide créée: {db_path}")
    print(f"📊 Taille: {os.path.getsize(db_path)} bytes")
    print(f"\n💡 Prochaine étape:")
    print(f"   1. Lancez: flutter run -d windows")
    print(f"   2. Cliquez sur ⚙️ pour générer les clés")

if __name__ == '__main__':
    create_empty_database()
