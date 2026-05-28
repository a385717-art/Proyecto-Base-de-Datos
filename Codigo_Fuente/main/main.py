import tkinter as tk
from tkinter import messagebox, ttk
import oracledb
import sys
import os


# 1. CAPA DE DATOS (Configuración y Enlace con Oracle Database 21c)
DB_USER = "EZEQUIEL"
DB_PASSWORD = "123789"  
DB_DSN = "localhost:1521/XEPDB1"

def conectar_base_datos():
    try:
        connection = oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN)
        print("[Capa de Datos]: Conexión establecida con éxito en Oracle Database.")
        return connection
    except oracledb.DatabaseError as e:
        print(f"[Capa de Datos - ERROR CRÍTICO]: No se pudo conectar a la base de datos: {e}")
        sys.exit(1)


if __name__ == "__main__":
    # Añadir el directorio padre (Codigo_Fuente) al path para importar `gui`
    sys.path.append(os.path.join(os.path.dirname(__file__), ".."))
    try:
        from gui.gui import App
    except Exception as e:
        print(f"No se pudo importar la interfaz gráfica: {e}")
        sys.exit(1)

    app = App()
    app.mainloop()