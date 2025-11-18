#!/usr/bin/env python3
"""
Script pour créer une base de données SQLite avec 200000 clés d'activation
Génère des clés cryptographiquement sécurisées sans pattern détectable
"""

import sqlite3
import os
import secrets
import string
import time
from datetime import datetime

def generate_activation_key():
    """
    Génère une clé d'activation cryptographiquement sécurisée
    Format: XXXX-XXXX-XXXX-XXXX
    Utilise secrets.token_bytes pour éviter tout pattern
    """
    # Utilise secrets.token_bytes pour une vraie randomisation cryptographique
    random_bytes = secrets.token_bytes(16)
    
    # Convertit en caractères alphanumériques
    chars = string.ascii_uppercase + string.digits
    key_chars = []
    
    for byte in random_bytes:
        # Utilise chaque byte pour sélectionner un caractère
        key_chars.append(chars[byte % len(chars)])
    
    # Formate en XXXX-XXXX-XXXX-XXXX
    key = '-'.join([
        ''.join(key_chars[0:4]),
        ''.join(key_chars[4:8]),
        ''.join(key_chars[8:12]),
        ''.join(key_chars[12:16])
    ])
    
    return key

def create_database_with_keys(num_keys=200000):
    db_path = os.path.join('assets', 'activation_keys.db')
    txt_path = 'CLES_TEST.txt'
    
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
    
    print(f"📦 Génération de {num_keys:,} clés d'activation cryptographiquement sécurisées...")
    print(f"🔒 Aucun pattern détectable - Protection contre le reverse engineering")
    print(f"⏳ Cela peut prendre quelques minutes...")
    
    start_time = time.time()
    created_at = int(datetime.now().timestamp() * 1000)
    
    # Ouvre le fichier texte pour écrire toutes les clés
    with open(txt_path, 'w', encoding='utf-8') as txt_file:
        txt_file.write(f"# Clés d'Activation My Child\n")
        txt_file.write(f"# Générées le: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        txt_file.write(f"# Total: {num_keys:,} clés\n")
        txt_file.write(f"# Format: XXXX-XXXX-XXXX-XXXX\n")
        txt_file.write(f"# Sécurité: Cryptographiquement aléatoires (secrets.token_bytes)\n")
        txt_file.write(f"#\n")
        txt_file.write(f"# CONFIDENTIEL - NE PAS PARTAGER\n")
        txt_file.write(f"{'='*60}\n\n")
        
        # Génère les clés par batch pour optimiser
        batch_size = 10000
        total_inserted = 0
        keys_set = set()  # Pour éviter les doublons
        all_keys = []  # Pour stocker toutes les clés
        
        for batch_num in range(0, num_keys, batch_size):
            batch_keys = []
            
            # Génère un batch de clés uniques
            while len(batch_keys) < min(batch_size, num_keys - batch_num):
                key = generate_activation_key()
                
                # Vérifie l'unicité
                if key not in keys_set:
                    keys_set.add(key)
                    batch_keys.append((key, created_at))
                    all_keys.append(key)
            
            # Insert le batch dans la DB
            cursor.executemany(
                'INSERT INTO activation_keys (key_value, created_at) VALUES (?, ?)',
                batch_keys
            )
            conn.commit()
            
            # Écrit le batch dans le fichier texte
            for key, _ in batch_keys:
                txt_file.write(f"{key}\n")
            
            total_inserted += len(batch_keys)
            progress = (total_inserted / num_keys) * 100
            elapsed = time.time() - start_time
            keys_per_sec = total_inserted / elapsed if elapsed > 0 else 0
            eta = (num_keys - total_inserted) / keys_per_sec if keys_per_sec > 0 else 0
            
            print(f"   ✓ {total_inserted:,}/{num_keys:,} clés ({progress:.1f}%) - "
                  f"{keys_per_sec:.0f} clés/sec - ETA: {eta:.0f}s")
    
    elapsed_time = time.time() - start_time
    
    # Statistiques
    cursor.execute('SELECT COUNT(*) FROM activation_keys')
    count = cursor.fetchone()[0]
    
    conn.close()
    
    db_file_size = os.path.getsize(db_path)
    db_file_size_mb = db_file_size / (1024 * 1024)
    
    txt_file_size = os.path.getsize(txt_path)
    txt_file_size_mb = txt_file_size / (1024 * 1024)
    
    print(f"\n{'='*60}")
    print(f"✅ Génération terminée avec succès!")
    print(f"{'='*60}")
    print(f"\n📊 Statistiques:")
    print(f"   - Clés générées: {count:,}")
    print(f"   - Temps total: {elapsed_time:.2f} secondes")
    print(f"   - Vitesse moyenne: {count/elapsed_time:.0f} clés/seconde")
    
    print(f"\n📁 Fichiers créés:")
    print(f"   1. Base de données SQLite:")
    print(f"      - Fichier: {db_path}")
    print(f"      - Taille: {db_file_size_mb:.2f} MB ({db_file_size:,} bytes)")
    
    print(f"\n   2. Fichier texte (backup):")
    print(f"      - Fichier: {txt_path}")
    print(f"      - Taille: {txt_file_size_mb:.2f} MB ({txt_file_size:,} bytes)")
    
    # Affiche quelques exemples de clés
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT key_value FROM activation_keys ORDER BY RANDOM() LIMIT 10')
    examples = cursor.fetchall()
    conn.close()
    
    print(f"\n🔑 Exemples de clés générées (aléatoires):")
    for i, (key,) in enumerate(examples, 1):
        print(f"   {i:2d}. {key}")
    
    # Analyse de sécurité
    print(f"\n🔒 Analyse de sécurité:")
    print(f"   - Algorithme: secrets.token_bytes (cryptographiquement sécurisé)")
    print(f"   - Espace de clés: 36^16 = 7.96 × 10^24 combinaisons possibles")
    print(f"   - Clés utilisées: {count:,} ({(count / (36**16)) * 100:.2e}% de l'espace)")
    print(f"   - Probabilité de collision: ~0% (négligeable)")
    print(f"   - Protection: Aucun pattern séquentiel détectable")
    
    print(f"\n💡 Les clés sont prêtes à être utilisées!")
    print(f"⚠️  IMPORTANT: Gardez CLES_TEST.txt en sécurité (CONFIDENTIEL)")

if __name__ == '__main__':
    create_database_with_keys(200000)
