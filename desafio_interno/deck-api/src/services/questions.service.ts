import { Deck } from "../models/deck.model";
import { Question } from "../models/question.model";
import { dbQuery } from "./db.service";

const checkIfQuestionExists = async (questionId: number): Promise<boolean> => {
    const decks = await dbQuery(
        'SELECT * FROM questions WHERE id = ?',
        [questionId],
    );

    return (decks as Deck[])[0] !== undefined;
};

const create = async (deckId: number, question: Question) => {
    await dbQuery(
        'INSERT INTO questions (ask, answer, deck_id) VALUES(?, ?, ?)',
        [question.ask, question.answer, deckId],
    );

    const lastQuestionId = await dbQuery('SELECT id from questions order by ROWID DESC limit 1') as any;

    const questionDB = await dbQuery(
        'SELECT id, ask, answer FROM questions WHERE deck_id = ? AND id = ?',
        [deckId, lastQuestionId[0]['id']],
    ) as any;

    return {
        id: questionDB[0].id,
        ask: questionDB[0].ask,
        answer: questionDB[0].answer,
    } as Question;
}

const getAll = async (deckId: number) => {
    const questions = await dbQuery(
        'SELECT * FROM questions WHERE questions.deck_id = ?',
        [deckId],
    );

    const mappedQuestions = (questions as Question[]).map((question: any) => {
        return {
            id: question.id,
            ask: question.ask,
            answer: question.answer,
        };
    });

    return mappedQuestions;
}

const remove = async (deckId: number, id: number) => {
    await dbQuery(
        'DELETE FROM questions WHERE deck_id = ? AND id = ?',
        [deckId, id],
    );
}

export const questionsService = {
    checkIfQuestionExists,
    create,
    getAll,
    remove,
}