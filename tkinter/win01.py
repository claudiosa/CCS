from tkinter import *

obj_window = Tk()


# add widgets here
obj_window.geometry("400x200+50+50")
obj_window.title("Title in the Window")

## 
btn=Button(obj_window, text="This is Button widget", fg='blue')
btn.place(x=80, y=100)
lbl=Label(obj_window, text="This is Label widget", fg='red', font=("Helvetica", 16))
lbl.place(x=60, y=50)
txtfld=Entry(obj_window, text="This is Entry Widget", bd=5)
txtfld.place(x=80, y=150)


obj_window.mainloop()