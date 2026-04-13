# E-Commerce Management System

A full-stack e-commerce platform built as a Database Systems coursework project at BITS Pilani. Features a normalized MySQL relational database backend and a Python Tkinter desktop GUI for end-to-end e-commerce workflows.

---

## Features

### GUI (gui.py)
- **Customer Registration** — new user sign-up with auto-generated customer ID
- **Product Browsing** — view all products with name, price, description, discount, and category
- **Order Tracking** — view full order history (order ID, date, price, status, address)
- **Shipment Tracking** — look up shipment status via tracking number
- **Address Management** — view and add delivery addresses
- **Reviews** — read average ratings and individual reviews; submit new reviews for any product

### Database (SQL)
17 implemented query workflows covering:
- Product search by category and recommendations for similar/frequently-bought-together products
- Full order placement with coupon code application, inventory update, and payment initiation
- Order cancellation with automatic refund generation
- Payment history and refund tracking
- Trending products view

---

## Schema

The database (`ecom`) contains 9 normalized tables:

| Table | Description |
|---|---|
| `Customers` | Customer profiles with email and phone validation |
| `Customer_Location` | Multiple delivery addresses per customer |
| `Customer_City` / `Customer_State` | Location normalization (3NF) |
| `Products` | Product catalog with effective price (post-discount) |
| `Coupons` | Discount coupon codes |
| `Orders` | Order records with status, coupon, and delivery address |
| `Has` | Order line items (order ↔ product junction) |
| `Cart` | Active shopping cart per customer |
| `Payment` | Payment records; negative amounts represent refunds |
| `Shipping` | Shipment tracking with delivery executive contact |
| `Reviews` | Product ratings (1–5) and feedback |

---

## Setup

### Prerequisites
- Python 3.x
- MySQL 8.x
- `mysql-connector-python`

```bash
pip install mysql-connector-python
```

### Database Setup

1. Run schema creation:
```bash
mysql -u root -p < Tables_Creation.sql
```

2. Load seed data:
```bash
mysql -u root -p < Tables_Insertion.sql
```

### Running the GUI

Set your MySQL credentials as environment variables:
```bash
export DB_HOST=127.0.0.1
export DB_USER=root
export DB_PASSWORD=your_mysql_password
export DB_NAME=ecom
```

Then run:
```bash
python3 gui.py
```

Alternatively, edit the default values in the `db = mysql.connector.connect(...)` block at the top of `gui.py`.

### Sample Login
Use any customer ID from the seed data to log in as an existing user:

| Customer ID | Name |
|---|---|
| CS01 | Sandeep Kumar |
| CS02 | Priya Singh |
| CS03 | Rajesh Patel |
| CS10 | Vikas Singh |

---

## Project Structure

```
├── gui.py                  # Python Tkinter GUI application
├── Tables_Creation.sql     # MySQL schema — all table definitions and constraints
├── Tables_Insertion.sql    # Seed data — sample customers, products, orders, reviews
├── Queries.sql             # 17 annotated SQL query workflows
├── Documentation.pdf       # Full project report
└── Steps to Run GUI.rtf    # Quick-start guide
```

---

## Tech Stack

- **Backend:** MySQL 8 — normalized relational schema, constraints, views, transactions
- **Frontend:** Python 3, Tkinter, ttk (Treeview)
- **Connector:** mysql-connector-python
