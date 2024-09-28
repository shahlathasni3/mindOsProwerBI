const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");

admin.initializeApp();
const app = express();

// Middleware to parse JSON
app.use(express.json());

// Endpoint to get user data by user ID
app.get("/user/:id", async (req, res) => {
  const userId = req.params.id;

  try {
    const userDoc = await admin.firestore().collection("users").doc(userId).get();

    if (!userDoc.exists) {
      return res.status(404).send("User not found");
    }

    res.status(200).json({ id: userDoc.id, ...userDoc.data() });
  } catch (error) {
    console.error("Error fetching user data:", error);
    res.status(500).send("Internal Server Error");
  }
});

// Export the API as a Cloud Function
exports.api = functions.https.onRequest(app);


















//const {onRequest} = require("firebase-functions/v2/https");
//const logger = require("firebase-functions/logger");
