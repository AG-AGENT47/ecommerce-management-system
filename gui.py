import tkinter as tk
from tkinter import ttk

from tkinter import *
from tkinter import messagebox
import mysql.connector
import os
import random


# Connect to the database
# Set DB_HOST, DB_USER, DB_PASSWORD, DB_NAME as environment variables,
# or edit the defaults below to match your local MySQL setup.
db = mysql.connector.connect(
  host=os.environ.get("DB_HOST", "127.0.0.1"),
  user=os.environ.get("DB_USER", "root"),
  password=os.environ.get("DB_PASSWORD", "your_mysql_password"),
  database=os.environ.get("DB_NAME", "ecom")
)

def get_username(user_id):
    cursor = db.cursor()
    cursor.execute("SELECT c_name FROM customers WHERE c_id = %s", (user_id,))
    result = cursor.fetchone()
    if result:
        return result[0]
    else:
        return None

#to close window
def close_window(display):
    display.destroy()

def show_register_window():    
    # create a cursor object
    mycursor = db.cursor()

    def generate_customer_id():
        # Generate a random 5-digit integer between 10000 and 99999
        customer_id = random.randint(10000, 99999)
        # Check if the customer ID already exists in the database
        mycursor.execute("SELECT c_id FROM Customers WHERE c_id=%s", (str(customer_id),))
        result = mycursor.fetchone()
        # If the customer ID already exists, generate a new one
        while result is not None:
            customer_id = random.randint(10000, 99999)
            mycursor.execute("SELECT c_id FROM Customers WHERE c_id=%s", (str(customer_id),))
            result = mycursor.fetchone()
        # Return the unique customer ID
        return str(customer_id)

    # create the tkinter window
    window = tk.Toplevel(root)


    # set the window title
    window.title("Add Customer")

    # create the labels
    name_label = tk.Label(window, text="Name:")
    email_label = tk.Label(window, text="Email:")
    phone_label = tk.Label(window, text="Phone:")
    address_label = tk.Label(window, text="Address:")
    city_label = tk.Label(window, text="City:")
    state_label = tk.Label(window, text="State: ")
    #pincode_label = tk.Label(window, text= "Pincode:")


    # create the entry fields
    name_entry = tk.Entry(window)
    email_entry = tk.Entry(window)
    phone_entry = tk.Entry(window)
    address_entry = tk.Entry(window)
    city_entry = tk.Entry(window)
    state_entry = tk.Entry(window)
    pincode_entry = tk.Entry(window)
    pincode_entry.insert(0, "Enter Pincode")

    # create the submit button
    def submit():
        # get the values from the entry fields
        name = name_entry.get()
        email = email_entry.get()
        phone = phone_entry.get()
        address = address_entry.get()
        city = city_entry.get()
        state = state_entry.get()
        pincode= pincode_entry.get()
        customer_id = generate_customer_id()

        # insert the data into the database
        sql = "INSERT INTO Customers (c_id,c_name, c_email, c_phoneno) VALUES (%s, %s, %s, %s)"
        val = (customer_id,name, email, phone)
        mycursor.execute(sql, val)
        #mydb.commit()

        sql = "INSERT INTO Customer_Location (c_id,c_address_sno, c_address_house, c_address_pincode) VALUES (%s, %s, %s, %s)"
        val = (customer_id, '1' , address, pincode)
        mycursor.execute(sql, val)
        #mydb.commit()

        sql = "INSERT IGNORE INTO Customer_City (c_city, c_pincode) VALUES (%s, %s)"
        val = (city, pincode)
        mycursor.execute(sql, val)
        #mydb.commit()

        sql = "INSERT IGNORE INTO Customer_State (c_state, c_city) VALUES (%s, %s)"
        val = (state, city)
        mycursor.execute(sql, val)

        messagebox.showinfo("Customer ID", f"Your customer ID is {customer_id}")

        db.commit()

        # clear the entry fields
        name_entry.delete(0, tk.END)
        email_entry.delete(0, tk.END)
        phone_entry.delete(0, tk.END)
        address_entry.delete(0, tk.END)
        city_entry.delete(0, tk.END)
        state_entry.delete(0, tk.END)
        pincode_entry.delete(0, tk.END)


    submit_button = tk.Button(window, text="Submit", command=submit)

    # pack the labels, entry fields and submit button
    name_label.pack()
    name_entry.pack()
    email_label.pack()
    email_entry.pack()
    phone_label.pack()
    phone_entry.pack()
    address_label.pack()
    address_entry.pack()
    city_label.pack()
    city_entry.pack()
    state_label.pack()
    state_entry.pack()
    pincode_entry.pack()
    submit_button.pack()

    # start the tkinter event loop
    #window.mainloop()

def show_browse_window():
    browse_window = tk.Toplevel(root)
    browse_window.title("BROWSE PRODUCTS")
    home_button=tk.Button(browse_window, text="HOME", command=lambda: close_window(browse_window))
    mycursor = db.cursor()

    # execute a select statement to retrieve the data
    mycursor.execute("SELECT p_name, p_price, p_description, p_discount, p_category FROM products")

    # get all the rows of the result set
    rows = mycursor.fetchall()

    # create a treeview widget to display the data
    tree = ttk.Treeview(browse_window, columns=("name", "price", "description", "discount", "category"), show="headings")


    # add columns to the treeview widget
    tree.heading("name", text="Name")
    tree.heading("price", text="Price")
    tree.heading("description", text="Description")
    tree.heading("discount", text="Discount(%)")
    tree.heading("category", text="Category")

    tree.pack()

    # add rows to the treeview widget
    for row in rows:
        tree.insert("", tk.END, values=row)


    # Create the 'Add to cart' button
    def add_to_cart():
        # Get the selected row from the tree view
        selected_item = tree.focus()
        if selected_item:
            row = tree.item(selected_item)['values']
            
            # Insert the selected row into the 'cart' table
            #mycursor.execute('INSERT INTO cart (id, name, price, quantity) VALUES (%s, %s, %s, %s)', (row[0], row[1], row[2], 1))
            #db.commit()
            #mycursor.execute('INSERT INTO cart ()')
            #mycursor.execute("INSERT INTO cart (product_id, user_id, quantity) VALUES (<product_id_value>, <user_id_value>, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;")
            messagebox.showinfo("SUCESS", f"Your item {row[0]} is added succesfully")


    add_button = tk.Button(browse_window, text='Add to cart', command=add_to_cart)
    add_button.pack()
    home_button.pack()

def show_track_window():
    track_window = tk.Toplevel(root)
    track_window.title("TRACK PRODUCTS")
    user_id = user_id_entry.get()
    welcome_label = tk.Label(track_window, text=f"Welcome {user_id}")
    track_label = tk.Label(track_window, text="Enter Your Tracking Number:")
    track_entry = tk.Entry(track_window)

    def enter():
        track=track_entry.get()
        mycursor = db.cursor()
        #print(user_id)
        # execute a select statement to retrieve the data
        mycursor.execute("select* from shipping where s_tracking_id=%s AND o_id IN (select o_id from orders where c_id=%s )",(track,user_id))

        # get all the rows of the result set
        rows = mycursor.fetchall()

        # create a treeview widget to display the data
        tree = ttk.Treeview(track_window, columns=("TrackID","ArrivingDate","Deliver Phone No","Status","OrderID"), show="headings")


        # add columns to the treeview widget
        tree.heading("TrackID", text="Tracking ID")
        tree.heading("ArrivingDate", text="Date of Arrival")
        tree.heading("Deliver Phone No", text="Contact of Delivery exec.")
        tree.heading("Status", text="Status")
        tree.heading("OrderID", text="Order ID")
        
        tree.pack()

        # add rows to the treeview widget
        for row in rows:
            tree.insert("", tk.END, values=row)
    
    enter_button=tk.Button(track_window, text="ENTER", command=enter)    
    home_button=tk.Button(track_window, text="HOME", command=lambda: close_window(track_window))
    home_button.pack()
    track_label.pack()
    track_entry.pack()
    enter_button.pack()
    welcome_label.pack()

def show_adress_window():
    adress_window = tk.Toplevel(root)
    adress_window.title("ADRESS PORTAL")
    user_id = user_id_entry.get()
    home_button=tk.Button(adress_window, text="HOME", command=lambda: close_window(adress_window))
    # Create the tree view
    mycursor = db.cursor()
    #print(user_id)
    # execute a select statement to retrieve the data
    mycursor.execute("select c_address_house,c_address_pincode from customer_location where c_id=%s", (user_id,))

    # get all the rows of the result set
    rows = mycursor.fetchall()
    
    address_label = tk.Label(adress_window, text="Address:")
    city_label = tk.Label(adress_window, text="City:")
    state_label = tk.Label(adress_window, text="State: ")
    pincode_label = tk.Label(adress_window, text= "Pincode:")

    address_entry = tk.Entry(adress_window)
    city_entry = tk.Entry(adress_window)
    state_entry = tk.Entry(adress_window)
    pincode_entry = tk.Entry(adress_window)

    # create a treeview widget to display the data
    tree = ttk.Treeview(adress_window, columns=("adress","pincode"), show="headings")


    # add columns to the treeview widget
    tree.heading("adress", text="Address")
    tree.heading("pincode", text="Pincode")
    
    

    # add rows to the treeview widget
    for row in rows:
        tree.insert("", tk.END, values=row)
    def a_edit():
        # Get the selected row from the tree view
        selected_item = tree.focus()
        if selected_item:
            row = tree.item(selected_item)['values']
            
            # Insert the selected row into the 'cart' table
            #mycursor.execute('INSERT INTO cart (id, name, price, quantity) VALUES (%s, %s, %s, %s)', (row[0], row[1], row[2], 1))
            #db.commit()
            #mycursor.execute('INSERT INTO cart ()')
            #mycursor.execute("INSERT INTO cart (product_id, user_id, quantity) VALUES (<product_id_value>, <user_id_value>, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;")
            messagebox.showinfo("SUCESS", f"Your item {row[0]} is added succesfully")
    def a_add():
        address = address_entry.get()
        city = city_entry.get()
        state = state_entry.get()
        pincode= pincode_entry.get()
        
        sql = "INSERT IGNORE INTO Customer_Location (c_id,c_address_sno, c_address_house, c_address_pincode) VALUES (%s, %s, %s, %s)"
        val = (user_id, '28' , address, pincode)
        mycursor.execute(sql, val)
        #mydb.commit()

        sql = "INSERT IGNORE INTO Customer_City (c_city, c_pincode) VALUES (%s, %s)"
        val = (city, pincode)
        mycursor.execute(sql, val)
        #mydb.commit()

        sql = "INSERT IGNORE INTO Customer_State (c_state, c_city) VALUES (%s, %s)"
        val = (state, city)
        mycursor.execute(sql, val)
        db.commit()
        mycursor.execute("select c_address_house,c_address_pincode from customer_location where c_id=%s", (user_id,))
        rows = mycursor.fetchall()
        for item in tree.get_children():
            tree.delete(item)
        for row in rows:
            tree.insert("", tk.END, values=row)


    edit_button=tk.Button(adress_window,text="EDIT",command=a_edit)
    add_button=tk.Button(adress_window,text="ADD",command=a_add)

    address_label.pack()
    address_entry.pack()
    city_label.pack()
    city_entry.pack()
    state_label.pack()
    state_entry.pack()
    pincode_label.pack()
    pincode_entry.pack()
    home_button.pack()
    edit_button.pack()
    add_button.pack()
    tree.pack()

def show_orders_window():
    orders_window = tk.Toplevel(root)
    orders_window.title("YOUR ORDERS")
    #orders_window.geometry("300x200")
    user_id = user_id_entry.get()
    home_button=tk.Button(orders_window, text="HOME", command=lambda: close_window(orders_window))
    # Create the tree view
    mycursor = db.cursor()

    # execute a select statement to retrieve the data
    mycursor.execute("select o_id,o_date,o_price,o_status,o_house from orders where c_id=%s", (user_id,))

    # get all the rows of the result set
    rows = mycursor.fetchall()

    # create a treeview widget to display the data
    tree = ttk.Treeview(orders_window, columns=("order id", "date", "price", "status", "adress"), show="headings")


    # add columns to the treeview widget
    tree.heading("order id", text="Order id")
    tree.heading("date", text="Date")
    tree.heading("price", text="Price")
    tree.heading("status", text="Status")
    tree.heading("adress", text="Adress")

    tree.pack()

    # add rows to the treeview widget
    for row in rows:
        tree.insert("", tk.END, values=row)
    home_button.pack()

def show_review_window():
    review_window=tk.Toplevel(root)
    review_window.title("REVIEW CENTRE")
    name_label = tk.Label(review_window, text="Enter Product Name:")
    name_entry = tk.Entry(review_window)

    def show_read_window():
        pname=name_entry.get()
        read_window=tk.Toplevel(root)
        read_window.title("PAST REVIEWS")

        back_button=tk.Button(read_window, text="back", command=lambda: close_window(read_window))
        # Create the tree view
        mycursor = db.cursor()
        mycursor.execute("select avg(r_rating) from Reviews where p_id in (select p_id from products where p_name=%s)", (pname,))
        result = mycursor.fetchone()

        rate_label = tk.Label(read_window, text=f"The Average rating for {pname} is {result} ")


        # execute a select statement to retrieve the data
        mycursor.execute("select r_title,r_rating,r_feedback,r_date from Reviews where p_id in (select p_id from products where p_name=%s)", (pname,))

        # get all the rows of the result set
        rows = mycursor.fetchall()

        # create a treeview widget to display the data
        tree = ttk.Treeview(read_window, columns=("Title","Rating","Feedback","Date" ), show="headings")


        # add columns to the treeview widget
        tree.heading("Title", text="Title")
        tree.heading("Rating", text="Rating")
        tree.heading("Feedback", text="Feedback")
        tree.heading("Date", text="Date")
        rate_label.pack()
        tree.pack()

        # add rows to the treeview widget
        for row in rows:
            tree.insert("", tk.END, values=row)
        back_button.pack()
    
    def show_create_window():
        create_window = tk.Toplevel(root)
        pname=name_entry.get()
        mycursor = db.cursor()

        # set the window title
        create_window.title("Add Review")

        # create the labels
        title_label = tk.Label(create_window, text="TITLE:")
        rate_label = tk.Label(create_window, text="RATING(1-5):")
        review_label = tk.Label(create_window, text="REVIEW:")


        # create the entry fields
        title_entry = tk.Entry(create_window)
        rate_entry = tk.Entry(create_window)
        review_entry = tk.Entry(create_window)

        # create the submit button
        def submit():
            # get the values from the entry fields
            title = title_entry.get()
            rate = rate_entry.get()
            review = review_entry.get()

            # insert the data into the database
            sql = "INSERT INTO Reviews (p_id, r_title, r_rating, r_feedback, r_date) VALUES ((SELECT p_id FROM products WHERE p_name=%s),%s,%s,%s, CURRENT_DATE)"
            val = (pname,title,rate,review)
            mycursor.execute(sql, val)

            db.commit()

            # clear the entry fields
            title_entry.delete(0, tk.END)
            rate_entry.delete(0, tk.END)
            review_entry.delete(0, tk.END)

        submit_button = tk.Button(create_window, text="Submit", command=submit)

        # pack the labels, entry fields and submit button
        title_label.pack()
        title_entry.pack()
        rate_label.pack()
        rate_entry.pack()
        review_label.pack()
        review_entry.pack()
        submit_button.pack()


    create_button=tk.Button(review_window, text="Create a Review",command= show_create_window)
    read_button=tk.Button(review_window, text="Read Reviews", command=show_read_window)
    close_button=tk.Button(review_window, text="HOME", command=lambda: close_window(review_window))
    name_label.pack()
    name_entry.pack()
    create_button.pack()
    read_button.pack()
    close_button.pack()


def show_welcome_window():
    user_id = user_id_entry.get()
    username = get_username(user_id)
    if username:
        welcome_window = tk.Toplevel(root)
        welcome_window.geometry("300x200")
        welcome_window.title("HOME")
        welcome_label = tk.Label(welcome_window, text=f"Welcome {username}")
        browse_button = tk.Button(welcome_window, text="BROWSE", command=show_browse_window)
        track_button=tk.Button(welcome_window, text="TRACK", command=show_track_window)
        adress_button=tk.Button(welcome_window, text="ADDRESS", command=show_adress_window)
        orders_button=tk.Button(welcome_window, text="ORDERS", command=show_orders_window)
        review_button=tk.Button(welcome_window, text="REVIEWS", command=show_review_window)
        
        browse_button.pack()
        track_button.pack()
        review_button.pack()
        adress_button.pack()
        orders_button.pack()
        welcome_label.pack()
    else:
        error_label = tk.Label(root, text="User ID not found")
        error_label.pack()

root = tk.Tk()
root.title("User Login")

new_user_button = tk.Button(root, text="New User", command=show_register_window)
new_user_button.pack()

old_user_frame = tk.Frame(root)
old_user_frame.pack()
old_user_button = tk.Button(old_user_frame, text="Old User:", command=show_welcome_window)
old_user_button.pack(side="left")
user_id_label = tk.Label(old_user_frame, text="User ID:")
user_id_label.pack(side="left")
user_id_entry = tk.Entry(old_user_frame)
user_id_entry.pack(side="left")

# Start the main loop
root.mainloop()

# Close the database connection when the application is closed
db.close()
