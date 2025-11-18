#!/usr/bin/env python3
"""
Script pour générer des clés de test dans la base de données
"""

import sqlite3
import os
import time

def generate_key(index, timestamp):
    """Génère une clé au format MYCHILD-XXXXXX-YYYYYY"""
    part1 = str((timestamp + index) % 999999).zfill(6)
    part2 = str((timestamp * 7 + index * 13) % 999999).zfill(6)
    return f"MYCHILD-{part1}-{part2}"

def generate_keys(count=100):
    db_path = os.path.join('assets', 'activation_keys.db')
    
    if not os.path.exists(db_path):
        print("❌ Base de données non trouvée. Lancez d'abord: python generate_empty_db.py")
        return
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Vérifie combien de clés existent déjà
    cursor.execute("SELECT COUNT(*) FROM activation_keys")
    existing = cursor.fetchone()[0]
    
    if existing > 0:
        print(f"⚠️  {existing} clés existent déjà dans la base")
        response = input("Voulez-vous les supprimer et recommencer ? (o/n): ")
        if response.lower() == 'o':
            cursor.execute("DELETE FROM activation_keys")
            conn.commit()
            print("🗑️  Clés supprimées")
        else:
            print("❌ Annulé")
            conn.close()
            return
    
    timestamp = int(time.time())
    
    print(f"\n🔑 Génération de {count} clés...")
    
    keys_generated = []
    for i in range(count):
        key = generate_key(i, timestamp)
        cursor.execute(
            "INSERT INTO activation_keys (key_value, created_at) VALUES (?, ?)",
            (key, timestamp)
        )
        keys_generated.append(key)
        
        if (i + 1) % 10 == 0:
            print(f"   {i + 1}/{count} clés générées...")
    
    conn.commit()
    
    # Affiche quelques clés
    print(f"\n✅ {count} clés générées avec succès !")
    print(f"\n📋 Premières 10 clés (pour tests):")
    for i, key in enumerate(keys_generated[:10], 1):
        print(f"   {i}. {key}")
    
    # Statistiques
    cursor.execute("SELECT COUNT(*) FROM activation_keys")
    total = cursor.fetchone()[0]
    
    print(f"\n📊 Statistiques:")
    print(f"   Total de clés dans la base: {total}")
    print(f"   Taille du fichier: {os.path.getsize(db_path)} bytes")
    
    conn.close()
    
    print(f"\n💡 Prochaines étapes:")
    print(f"   1. Testez avec: flutter run -d windows")
    print(f"   2. Utilisez une des clés ci-dessus pour activer")
    print(f"   3. Pour générer 200 000 clés, utilisez l'app (bouton ⚙️)")

if __name__ == '__main__':
    import sys
    
    count = 100
    if len(sys.argv) > 1:
        try:
            count = int(sys.argv[1])
        except:
            print("Usage: python generate_test_keys.py [nombre_de_clés]")
            sys.exit(1)
    
    generate_keys(count)
