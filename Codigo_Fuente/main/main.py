import tkinter as tk
from tkinter import messagebox, ttk
import oracledb
import sys

# ============================================================================
# 1. CAPA DE DATOS (Configuración y Enlace con Oracle Database 21c)
# ============================================================================
DB_USER = "EZEQUIEL"
DB_PASSWORD = "123789"  # <-- Cambia esto por la contraseña de tu usuario Oracle
DB_DSN = "localhost:1521/XEPDB1"

def conectar_base_datos():
    try:
        # Se remueve 'thin=True' ya que la versión actual de oracledb lo maneja por defecto
        connection = oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN)
        print("[Capa de Datos]: Conexión establecida con éxito en Oracle Database.")
        return connection
    except oracledb.DatabaseError as e:
        print(f"[Capa de Datos - ERROR CRÍTICO]: No se pudo conectar a la base de datos: {e}")
        sys.exit(1)