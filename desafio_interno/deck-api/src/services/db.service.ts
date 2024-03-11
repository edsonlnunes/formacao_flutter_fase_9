import fs from 'fs';
import dotenv from 'dotenv';
import sqlite3 from 'sqlite3';

dotenv.config();

const DATABASE_FILE = process.env.DATABASE_FILE || 'sqlite.db';

if (!DATABASE_FILE) {
    fs.writeFileSync(DATABASE_FILE, '');
}

export const connectDB = () => {
    let db = new sqlite3.Database(DATABASE_FILE!);
    return db;
}

export const createTablesIfNotExists = async () => {
    let db = connectDB();

    try {
        return await new Promise((resolve, reject) => {
            db.prepare(`
                CREATE TABLE IF NOT EXISTS users (
                    id INTEGER NOT NULL,
                    email TEXT NOT NULL UNIQUE,
                    password TEXT NOT NULL,
                    PRIMARY KEY(id AUTOINCREMENT)
                )
            `)
            .run(err => {
                if (err) {
                    reject(err);
                    return;
                }
                resolve(true);
            })
            .finalize();

            db.prepare(`
                CREATE TABLE IF NOT EXISTS decks (
                    id INTEGER NOT NULL,
                    name TEXT NOT NULL,
                    user_id INTEGER NOT NULL,
                    PRIMARY KEY(id AUTOINCREMENT),
                    FOREIGN KEY (user_id) REFERENCES users(id)
                )
            `)
            .run(err => {
                if (err) {
                    reject(err);
                    return;
                }
                resolve(true);
            })
            .finalize();

            db.prepare(`
                CREATE TABLE IF NOT EXISTS questions (
                    id INTEGER NOT NULL,
                    ask TEXT NOT NULL,
                    answer TEXT NOT NULL,
                    deck_id INTEGER NOT NULL,
                    PRIMARY KEY(id AUTOINCREMENT),
                    FOREIGN KEY (deck_id) REFERENCES decks(id)
                )
            `)
            .run(err => {
                if (err) {
                    reject(err);
                    return;
                }
                resolve(true);
            })
            .finalize();
        });
    } finally {
        db.close();
    }
}

export const dbQuery = async (query: string, params?: any[]) => {
    let db = connectDB();
    
    try {
        return await new Promise((resolve, reject) => {
            db.all(query, params, (err, rows) => {
                if (err) {
                    reject(err);
                    return;
                }
                resolve(rows);
            });
        });
    } finally {
        db.close();
    }
}