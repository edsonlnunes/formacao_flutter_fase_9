import { User } from "../models/user.model";
import { dbQuery } from "./db.service";

const checkIfUserExists = async (email: string, password?: string) => {
    const result = await dbQuery(
        password !== null ?
            'SELECT id FROM users WHERE email = ? and password = ?' :
            'SELECT id FROM users WHERE email = ?',
        [email, password],
    );

    return (result as Object[]).length !== 0;
}

const create = async (user: User) => {
    await dbQuery(
        'INSERT INTO users (email, password) VALUES(?, ?)',
        [user.email, user.password],
    );
}

const login = async (email: string, password: string) => {
    const result = await dbQuery(
        'SELECT id FROM users WHERE email = ? AND password = ?',
        [email, password],
    );

    const userId = (result as User[])[0].id;

    return `token_user_id_${userId}`;
}

export const usersService = {
    checkIfUserExists,
    create,
    login,
}