import customtkinter as ctk
import subprocess
import ctypes

# Hide console window (Windows only)
ctypes.windll.user32.ShowWindow(
    ctypes.windll.kernel32.GetConsoleWindow(), 0
)

# Appearance
ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("dark-blue")

# Main window (smaller now)
root = ctk.CTk()
root.title("Apps")
root.geometry("200x280")  # smaller GUI
root.resizable(False, False)

# KEEP WINDOW ALWAYS ON TOP
root.attributes("-topmost", True)

# Scrollable frame (fits smaller window)
scrollable_frame = ctk.CTkScrollableFrame(root, width=200, height=280)
scrollable_frame.pack(pady=0)

# Open App Function
import os

def open_app(path, admin=False):
    if admin:
        subprocess.Popen(
            ["powershell", "-Command", f"Start-Process '{path}' -Verb RunAs"]
        )
    else:
        os.startfile(path)

# Apps list
apps = [
    ("Notepad", r"C:\Windows\System32\notepad.exe"),
    ("Calculator", "calc.exe"),
    ("File Explorer", "explorer.exe"),
    ("Chrome", r"C:\Program Files\Google\Chrome\Application\chrome.exe"),
    ("Cmd", "cmd.exe"),
    ("Roblox", r"C:\Users\Test\AppData\Local\Roblox\Versions\version-ad5d3e2906444472\RobloxPlayerBeta.exe"),
    ("Roblox Studio", r"C:\Users\Test\AppData\Local\Roblox\Versions\version-792bc2069be7464a\RobloxStudiobeta"),
]

# Create buttons
for name, path in apps:
    btn = ctk.CTkButton(
        scrollable_frame,
        text=name,
        corner_radius=10,
        height=35,
        fg_color="#2b2b2b",
        hover_color="#3d3d3d",
        command=lambda p=path: open_app(p)
    )
    btn.pack(pady=5, fill="x", padx=5)

root.mainloop()