import { Deck } from "../models/deck.model";
import { dbQuery } from "./db.service";

const checkIfDeckExists = async (deckId: number): Promise<boolean> => {
    const decks = await dbQuery(
        'SELECT * FROM decks WHERE id = ?',
        [deckId],
    );
    
    return (decks as Deck[])[0] !== undefined;
};

const create = async (userId: number, deck: Deck) => {
    await dbQuery(
        'INSERT INTO decks (name, user_id) VALUES(?, ?)',
        [deck.name, userId],
    );

    const lastDeckId = await dbQuery('SELECT id from decks order by ROWID DESC limit 1') as any;

    const deckDB = await dbQuery(
        'SELECT id, name FROM decks WHERE user_id = ? AND id = ?',
        [userId, lastDeckId[0]['id']],
    ) as any;

    return {
        id: deckDB[0].id,
        name: deckDB[0].name,
        questions: [],
    } as Deck;
}

const getAll = async (userId: number) => {
    const decks = await dbQuery(
        'SELECT * FROM decks WHERE decks.user_id = ?',
        [userId],
    );
    
    const mappedDecks = await Promise.all(
        (decks as Deck[]).map(async (deck: any) => {
            const questions = await dbQuery(
                'SELECT id, ask, answer FROM questions WHERE questions.deck_id = ?',
                [deck.id],
            );

            return {
                id: deck.id,
                name: deck.name,
                questions: questions,
            }
        }
    ));

    return mappedDecks;
}

const remove = async (id: number) => {
    await dbQuery(
        'DELETE FROM decks WHERE id = ?',
        [id],
    );
}

export const decksService = {
    checkIfDeckExists,
    create,
    getAll,
    remove,
}