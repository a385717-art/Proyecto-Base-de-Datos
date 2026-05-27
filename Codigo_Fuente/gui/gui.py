import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import sys, os
# Asegurar que el paquete `Codigo_Fuente`/path principal esté en sys.path
sys.path.append(os.path.join(os.path.dirname(__file__), ".."))
import importlib.util
main_path = os.path.join(os.path.dirname(__file__), "..", "main", "main.py")
spec = importlib.util.spec_from_file_location("project_main", main_path)
project_main = importlib.util.module_from_spec(spec)
spec.loader.exec_module(project_main)
conectar_base_datos = project_main.conectar_base_datos


class App(tk.Tk):
	def __init__(self):
		super().__init__()
		self.title("Proyecto - Interfaz de Base de Datos")
		self.geometry("900x600")

		self.conn = None
		self.create_widgets()
		self.connect_db()

	def create_widgets(self):
		paned = ttk.PanedWindow(self, orient=tk.HORIZONTAL)
		paned.pack(fill=tk.BOTH, expand=True)

		left_frame = ttk.Frame(paned, width=250)
		right_frame = ttk.Frame(paned)
		paned.add(left_frame, weight=1)
		paned.add(right_frame, weight=4)

		ttk.Label(left_frame, text="Tablas:").pack(anchor=tk.W, padx=8, pady=(8, 0))
		self.tables_list = tk.Listbox(left_frame)
		self.tables_list.pack(fill=tk.BOTH, expand=True, padx=8, pady=8)
		self.tables_list.bind("<<ListboxSelect>>", self.on_table_select)

		ttk.Button(left_frame, text="Refrescar", command=self.populate_tables).pack(padx=8, pady=(0, 8))

		# Right: query area and result treeview
		top_right = ttk.Frame(right_frame)
		top_right.pack(fill=tk.BOTH, expand=True)

		query_label = ttk.Label(top_right, text="Consulta SQL:")
		query_label.pack(anchor=tk.W, padx=8, pady=(8, 0))

		self.query_text = scrolledtext.ScrolledText(top_right, height=6)
		self.query_text.pack(fill=tk.X, padx=8, pady=4)

		btn_frame = ttk.Frame(top_right)
		btn_frame.pack(fill=tk.X, padx=8)
		ttk.Button(btn_frame, text="Ejecutar", command=self.execute_query).pack(side=tk.LEFT)
		ttk.Button(btn_frame, text="Limpiar", command=lambda: self.query_text.delete("1.0", tk.END)).pack(side=tk.LEFT, padx=8)

		# Results
		res_label = ttk.Label(top_right, text="Resultados:")
		res_label.pack(anchor=tk.W, padx=8, pady=(8, 0))

		self.tree = ttk.Treeview(top_right, columns=("c",), show="headings")
		self.tree.pack(fill=tk.BOTH, expand=True, padx=8, pady=8)

	def connect_db(self):
		try:
			self.conn = conectar_base_datos()
			self.populate_tables()
		except Exception as e:
			messagebox.showerror("Error conexión", f"No se pudo conectar a la base de datos:\n{e}")

	def populate_tables(self):
		if not self.conn:
			return
		try:
			cur = self.conn.cursor()
			cur.execute("SELECT table_name FROM user_tables ORDER BY table_name")
			rows = cur.fetchall()
			self.tables_list.delete(0, tk.END)
			for r in rows:
				self.tables_list.insert(tk.END, r[0])
			cur.close()
		except Exception as e:
			messagebox.showerror("Error", f"No se pudieron obtener las tablas:\n{e}")

	def on_table_select(self, event):
		selection = self.tables_list.curselection()
		if not selection:
			return
		table = self.tables_list.get(selection[0])
		sql = f"SELECT * FROM {table} WHERE ROWNUM <= 50"
		self.query_text.delete("1.0", tk.END)
		self.query_text.insert(tk.END, sql)
		self.execute_query()

	def execute_query(self):
		if not self.conn:
			messagebox.showwarning("Sin conexión", "No hay conexión a la base de datos.")
			return
		sql = self.query_text.get("1.0", tk.END).strip()
		if not sql:
			return
		try:
			cur = self.conn.cursor()
			cur.execute(sql)
			cols = [d[0] for d in cur.description] if cur.description else []
			rows = cur.fetchall()
			cur.close()

			# actualizar treeview
			self.tree.delete(*self.tree.get_children())
			self.tree["columns"] = cols if cols else ("c",)
			for col in cols:
				self.tree.heading(col, text=col)
				self.tree.column(col, width=120)
			for r in rows:
				self.tree.insert("", tk.END, values=r)
		except Exception as e:
			messagebox.showerror("Error ejecución", f"Error al ejecutar la consulta:\n{e}")


if __name__ == "__main__":
	app = App()
	app.mainloop()
