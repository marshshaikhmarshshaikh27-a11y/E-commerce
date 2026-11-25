# Qadri Enterprises - Premium Solar & Battery Storefront & Management Suite

> **Hyderabad's Premier Solar Inverters, Tubular Batteries & Energy Solutions Hub**  
> 📍 **Address:** Qazi Abdul Qayoom Road, Gari Khata, Hyderabad  
> 📞 **Contact:** 0313-8667109 / 0315-3857383  

---

## 🌟 Features Overview

### 1. Modern Responsive Storefront
- **Pixel-Perfect Hero & Announcement Bar**: 100% responsive across mobile, tablet, and desktop viewports.
- **Official Brand Collections**: Daewoo Battery, Inverex Solar, Phoenix Batteries, Osaka, AGS, Exide, and Crown Solar.
- **Direct Categorization**:
  - Solar Inverters (Hybrid & On-Grid: 1.2KW, 2.5KW, 3.2KW, 6KW, 10KW)
  - Tubular Deep Cycle Batteries (100 Power, 150 Power, 250 Power)
  - Maintenance-Free Dry Batteries (100 Power, 150 Power, 250 Power)
  - Battery Tonics, Distilled Water & Maintenance Accessories
- **Interactive Cart & One-Click Checkout**: Direct delivery orders with auto-generated order IDs (`#QE-XXXXX`) and instant WhatsApp order confirmation.
- **Live Courier Tracking**: Real-time status inspection for dispatched orders.

### 2. Real-Time Solar & UPS Load Sizing Calculator
- **Interactive Household Appliances Grid**:
  - Ceiling Fans (with Normal 80W vs Inverter 45W toggle)
  - LED Lights (15W)
  - Smart LED TVs (90W)
  - Computers & WiFi Routers (80W)
  - Refrigerators (Inverter 180W vs Standard 350W)
  - Deep Freezers (300W)
  - Inverter ACs (1.0 Ton 950W vs 1.5 Ton 1450W)
  - Water Pumps & Donky Motors (0.5 HP vs 1.0 HP)
  - Washing Machines (350W)
- **Desired Backup Hours Selector**: 2h (Quick), 4h (Standard), 6h (Night), 8h (Full Overnight), 10h+ (Off-Grid).
- **System Voltage Selector**: 12V (Single Battery), 24V (2 Batteries), 48V (4 Batteries).
- **Automated Sizing Engine**:
  - Continuous running watts calculation
  - Peak starting surge estimation for motors and compressors
  - Battery Ah sizing formula: $\text{Ah} = \frac{\text{Watts} \times \text{Hours}}{\text{System Volts} \times 0.80 \times 0.85}$
  - Recommended Daewoo/Phoenix battery models with required unit count
  - Recommended Inverex/Crown hybrid inverters
  - 585W bifacial solar panels requirement
  - Monthly HESCO electricity bill savings estimation in PKR
- **1-Click Order Setup**: Directly adds the recommended setup to the shopping cart and opens checkout.
- **WhatsApp Consultation**: Generates a pre-filled technical inquiry sent directly to showroom solar engineers.

### 3. Staff & Management Admin Dashboard
- **Security Passcode Protected**: Secure admin authentication gateway (`#adminAuthModal`).
- **6 Full Operating Tabs**:
  1. **Dashboard**: Live stats, animated volume chart, recent orders feed, top sellers, and low-stock alerts.
  2. **Products**: Complete product catalog manager with real-time add, edit, and delete functionality.
  3. **Orders**: Full order lifecycle management (Pending, Dispatched, Delivered, Cancelled) with WhatsApp notification triggers.
  4. **Customers**: Customer purchase history and directory.
  5. **Inventory**: Real-time stock levels, restock buttons, and stock status indicators.
  6. **Reports**: Revenue breakdown, top selling categories, and export capabilities.

---

## 🚀 Running Locally

1. **Direct Preview**:
   Double click `index.html` in any modern web browser (Edge, Chrome, Firefox).

2. **With REST API Server**:
   ```bash
   npm install
   npm start
   # Server starts at http://localhost:3000
   ```

---

## 📦 Project Structure

```text
├── assets/
│   └── images/              # Ultra-HD product images & 3D showcase renders
├── data/
│   └── db.json              # REST API database (products, orders, customers)
├── index.html               # Main responsive Single-Page Application (SPA)
├── package.json             # Express & Node dependencies
├── server.js                # Backend REST API server
└── README.md                # Project documentation
```
