# pyInstaller Grade.py --onefile --noconsole

from tkinter import *
from tkinter import scrolledtext
from tkinter.messagebox import showinfo
from random import randint, shuffle

def click():                    # функция, срабатывающая по клику на кнопку
    output.delete(1.0, END)     # очищаем поле вывода пароля
    string = ''
    listing=[]
    charlist = [33, 47, 58, 64, 91, 96, 123, 126]
    a = int(spin.get())  # получаем длину пароля из спина
    i=0
    if en_let.get()==0 and en_num.get()==0 and en_char.get()==0 and en_uplet.get()==0:
        showinfo(title="Info", message="Нужно выбрать хотя бы один тип символов")
    else:
        while i < a:
            if en_let.get()==1:
                string = string+chr(randint(97, 122))
                i+=1
            if en_uplet.get()==1:
                if i == a:
                    break
                else:
                    string = string+chr(randint(65, 90))
                    i += 1
            if en_num.get()==1:
                if i == a:
                    break
                else:
                    string = string+chr(randint(48, 57))
                    i += 1
            if en_char.get()==1:
                if i == a:
                    break
                else:
                    diap=randint(0,3)
                    margin_1=charlist[2*diap]
                    margin_2=charlist[2*diap+1]
                    string = string+chr(randint(margin_1, margin_2))
                    i += 1
    listing=list(string)
    shuffle(listing)
    string="".join(listing)
    output.insert(INSERT, string)   # записываем в поле вывода сгенерированную последовательность

window = Tk()               # создаем окно программы
window.title("Генерация паролей")   # заголовок окна
#window.iconbitmap(default='key_password.ico') # favicon через iconbitmap
#icon=PhotoImage(file='free-key.png')    # favicon через iconphoto False - не исп.фавикон на всех окнах программы
#window.iconphoto(False, icon)
window.geometry('450x300+100+150')          # размеры окна плюс смещение на экране
#window.resizable(False, False)     # запрет изменения размеров окна
window.attributes('-alpha', 0.87)   # установка атрибута прозрачности для окна

window.columnconfigure(index=0, weight=150)
window.columnconfigure(index=1, weight=150)
window.columnconfigure(index=2, weight=150)
#window.rowconfigure(index, weight)

lbl=Label(window, text="Длина пароля", font=("Arial", 12))  # текстовое поле
lbl.grid(column=0, row=0, sticky=W)                                            # расположение текстового поля

#labl=Label(window, text="Длина строки", font=("Arial", 12))  # текстовое поле длина сгенеренной строки
#labl.grid(column=3, row=8, sticky=E)



spin_default=IntVar()                                               # Привязываем значение виджета к переменной типа Int
spin_default.set(16)                                                # устанавливаем значение переменной по умолчанию в 16
spin = Spinbox(window, from_=4, to=64, width=4, textvariable=spin_default)  # спин для выбора длины пароля
spin.grid(column=1, row=0, sticky=W)                                        # расположение спина

btn=Button(window,text="Сгенерировать пароль", font=("Arial", 12), command=click) # кнопка TKinter
btn.grid(column=2, row=0, sticky=E, padx=10)                                             # расположение кнопки


output=scrolledtext.ScrolledText(window, width=10, height=1, font=("Arial", 14))    # поле вывода пароля
output.grid(column=0, columnspan=3, row=2, sticky=EW)                                         # расположение поля вывода


en_let=IntVar()
en_let.set(1)                                          # по умолчанию стр.буквы в пароле есть
chk_1=Checkbutton(text="Строчные буквы", variable=en_let)       # чекбокс для строчных букв (97-122)
chk_1.grid(column=0, row=3, sticky=W)

en_uplet=IntVar()                                           #
en_uplet.set(1)
chk_1=Checkbutton(text="Заглавные буквы", variable=en_uplet)       # чекбокс для заглавных букв (65-90)
chk_1.grid(column=0, row=4, sticky=W)


en_num=IntVar()
en_num.set(1)                                           # цифры есть по умолчанию
chk_1=Checkbutton(text="Цифры", variable=en_num)       # чекбокс для цифр (48-57)
chk_1.grid(column=0, row=5, sticky=W)

en_char=IntVar()                                           #
chk_1=Checkbutton(text="Спецсимволы", variable=en_char)       # чекбокс для спецсимволов (33-47, 58-64, 91-96, 123-126)
chk_1.grid(column=0, row=6, sticky=W)



window.mainloop()