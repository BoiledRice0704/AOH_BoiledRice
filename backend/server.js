const express = require('express');
const app = express();
const dotenv = require('dotenv');
const cors = require('cors');
const connectDatabase = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const userDataRoutes = require('./routes/userdataRoutes');
const sendCrypto = require('./controllers/faucet/sendCryptoFunction');
const userRoutes = require('./routes/userRoutes');
const userInfoRoutes = require('./routes/userInfoRoutes');
const qrCodeRoutes = require('./routes/qrCodeRoutes');
const wasteRoutes = require('./routes/wasteRoutes');

const baseUrl = process.env.NODE_URL

// Load environment variables
dotenv.config();

// Parse JSON bodies
app.use(express.json());

// Enable CORS
app.use(cors());

// Define routes
app.get('/', (req, res) => {
  res.send('Hello World!');
});

// Connect to the database
connectDatabase();


// Use routes with base URL
app.use(`${baseUrl}/auth`, authRoutes);
app.use(`${baseUrl}/user`, userDataRoutes);
app.use(`${baseUrl}/user`, userRoutes);
app.use(`${baseUrl}/info`, userInfoRoutes);
app.use(`${baseUrl}/qrcode`, qrCodeRoutes);
app.use(`${baseUrl}/`, wasteRoutes);

// Get port from environment variable or use default
const PORT = process.env.PORT || 3000;

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

