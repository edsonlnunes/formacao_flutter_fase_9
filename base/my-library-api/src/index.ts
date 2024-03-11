import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import express from 'express';
import { initRoutes } from './routes';
import { createTablesIfNotExists } from './services/db.service';

dotenv.config();

const PORT = process.env.PORT || 8080;

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

initRoutes(app);

app.listen(PORT, async () => {
    console.log('Server started on port ' + PORT)
    await createTablesIfNotExists();
});