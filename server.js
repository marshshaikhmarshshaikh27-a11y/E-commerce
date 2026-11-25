import http from 'http';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

let PORT = parseInt(process.env.PORT, 10) || 3000;
const DB_FILE = path.join(__dirname, 'data', 'db.json');

// Read Database Helper
function readDB() {
  try {
    const raw = fs.readFileSync(DB_FILE, 'utf-8');
    return JSON.parse(raw);
  } catch (err) {
    console.error('Error reading db.json:', err);
    return { products: [], orders: [], inquiries: [] };
  }
}

// Write Database Helper
function writeDB(data) {
  try {
    fs.writeFileSync(DB_FILE, JSON.stringify(data, null, 2), 'utf-8');
    return true;
  } catch (err) {
    console.error('Error writing db.json:', err);
    return false;
  }
}

// MIME Types
const mimeTypes = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.svg': 'image/svg+xml'
};

// HTTP Server
const server = http.createServer((req, res) => {
  // CORS Headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  const parsedUrl = new URL(req.url, `http://${req.headers.host || 'localhost'}`);
  const pathname = parsedUrl.pathname;

  // ==========================================
  // REST API ENDPOINTS
  // ==========================================

  // 1. GET /api/products
  if (pathname === '/api/products' && req.method === 'GET') {
    const db = readDB();
    let result = db.products || [];

    const category = parsedUrl.searchParams.get('category');
    const brand = parsedUrl.searchParams.get('brand');
    const batteryType = parsedUrl.searchParams.get('batteryType');
    const search = parsedUrl.searchParams.get('search');

    if (category && category !== 'all') {
      result = result.filter(p => p.category.toLowerCase().includes(category.toLowerCase()));
    }
    if (brand && brand !== 'all') {
      result = result.filter(p => p.brand.toLowerCase() === brand.toLowerCase());
    }
    if (batteryType && batteryType !== 'all') {
      result = result.filter(p => p.batteryType.toLowerCase() === batteryType.toLowerCase());
    }
    if (search) {
      result = result.filter(p => 
        p.title.toLowerCase().includes(search.toLowerCase()) || 
        p.brand.toLowerCase().includes(search.toLowerCase())
      );
    }

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(result));
    return;
  }

  // 2. POST /api/products
  if (pathname === '/api/products' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const newProduct = JSON.parse(body);
        newProduct.id = `qe-p${Date.now()}`;
        const db = readDB();
        db.products.unshift(newProduct);
        writeDB(db);

        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, product: newProduct }));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Invalid JSON payload' }));
      }
    });
    return;
  }

  // 3. PUT /api/products/:id
  if (pathname.startsWith('/api/products/') && req.method === 'PUT') {
    const id = pathname.replace('/api/products/', '');
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const updates = JSON.parse(body);
        const db = readDB();
        const index = db.products.findIndex(p => p.id === id);
        if (index === -1) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Product not found' }));
          return;
        }
        db.products[index] = { ...db.products[index], ...updates };
        writeDB(db);
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, product: db.products[index] }));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Invalid JSON payload' }));
      }
    });
    return;
  }

  // 4. DELETE /api/products/:id
  if (pathname.startsWith('/api/products/') && req.method === 'DELETE') {
    const id = pathname.replace('/api/products/', '');
    const db = readDB();
    db.products = db.products.filter(p => p.id !== id);
    writeDB(db);
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ success: true }));
    return;
  }

  // 5. GET /api/orders
  if (pathname === '/api/orders' && req.method === 'GET') {
    const db = readDB();
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(db.orders || []));
    return;
  }

  // 6. POST /api/orders
  if (pathname === '/api/orders' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const orderData = JSON.parse(body);
        const db = readDB();
        const newOrder = {
          id: `#QE-${Math.floor(10000 + Math.random() * 90000)}`,
          customer: orderData.customer,
          phone: orderData.phone,
          city: orderData.city,
          address: orderData.address,
          amount: orderData.amount,
          status: 'Pending',
          date: 'Just Now',
          items: orderData.items,
          itemsDetail: orderData.itemsDetail || [],
          paymentMethod: orderData.paymentMethod || 'Cash on Delivery (COD)'
        };
        db.orders.unshift(newOrder);
        writeDB(db);

        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, order: newOrder }));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Invalid JSON payload' }));
      }
    });
    return;
  }

  // 7. PUT /api/orders/:id/status
  if (pathname.startsWith('/api/orders/') && pathname.endsWith('/status') && req.method === 'PUT') {
    const parts = pathname.split('/');
    const orderId = decodeURIComponent(parts[3]);
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const { status } = JSON.parse(body);
        const db = readDB();
        const order = db.orders.find(o => o.id === orderId);
        if (order) {
          order.status = status;
          writeDB(db);
          res.writeHead(200, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ success: true, order }));
        } else {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Order not found' }));
        }
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Invalid JSON' }));
      }
    });
    return;
  }

  // 8. GET /api/track/:orderId
  if (pathname.startsWith('/api/track/') && req.method === 'GET') {
    const orderId = decodeURIComponent(pathname.replace('/api/track/', ''));
    const db = readDB();
    const order = db.orders.find(o => o.id.toLowerCase() === orderId.toLowerCase() || o.id.replace('#', '').toLowerCase() === orderId.replace('#', '').toLowerCase());
    if (order) {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ success: true, order }));
    } else {
      res.writeHead(404, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ success: false, error: 'Order not found. Please check Order ID format (e.g. #QE-10248).' }));
    }
    return;
  }

  // 9. POST /api/contact
  if (pathname === '/api/contact' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const inquiry = JSON.parse(body);
        inquiry.id = `inq-${Date.now()}`;
        inquiry.date = 'Just Now';
        const db = readDB();
        if (!db.inquiries) db.inquiries = [];
        db.inquiries.unshift(inquiry);
        writeDB(db);

        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, inquiry }));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Invalid JSON' }));
      }
    });
    return;
  }

  // 10. GET /api/stats
  if (pathname === '/api/stats' && req.method === 'GET') {
    const db = readDB();
    const totalRevenue = (db.orders || []).reduce((sum, o) => sum + o.amount, 0);
    const stats = {
      totalOrders: (db.orders || []).length + 1248,
      totalCustomers: 8750 + Math.floor((db.orders || []).length * 1.5),
      totalRevenue: 562840 + totalRevenue,
      totalProducts: (db.products || []).length
    };
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(stats));
    return;
  }

  // ==========================================
  // STATIC FILE SERVING
  // ==========================================
  let filePath = path.join(__dirname, pathname === '/' ? 'index.html' : pathname);
  const ext = path.extname(filePath);
  const contentType = mimeTypes[ext] || 'text/html';

  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        fs.readFile(path.join(__dirname, 'index.html'), (error, defaultContent) => {
          res.writeHead(200, { 'Content-Type': 'text/html' });
          res.end(defaultContent, 'utf-8');
        });
      } else {
        res.writeHead(500);
        res.end(`Server Error: ${err.code}`);
      }
    } else {
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content, 'utf-8');
    }
  });
});

server.on('error', (e) => {
  if (e.code === 'EADDRINUSE') {
    console.warn(`Port ${PORT} in use, trying port ${PORT + 1}...`);
    PORT += 1;
    setTimeout(() => {
      server.close();
      server.listen(PORT, '0.0.0.0', () => {
        console.log(`⚡ Qadri Enterprises Full Stack Server running at http://localhost:${PORT}/`);
      });
    }, 500);
  } else {
    console.error('Server error:', e);
  }
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`⚡ Qadri Enterprises Full Stack Server running at http://localhost:${PORT}/`);
});
