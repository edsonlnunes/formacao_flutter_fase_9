import { Request, Response } from "express";
import { Question } from "../models/question.model";
import { decksService } from "../services/decks.service";
import { questionsService } from "../services/questions.service";
import { badRequest, internalError, notFound, unauthorized } from "../utils/req-errors.util";

const create = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const deckId = parseInt(req.params.deckId);

    if (!deckId) {
        return badRequest(res, 'INVALID_DECK_ID');
    }

    const question =  req.body as Question;

    if (!question) {
        return badRequest(res, 'INVALID_QUESTION');
    }

    if(!question.ask) {
        return badRequest(res, 'INVALID_QUESTION_ASK');
    }

    if(!question.answer) {
        return badRequest(res, 'INVALID_QUESTION_ANSWER');
    }

    const deckExists = await decksService.checkIfDeckExists(deckId);

    if (!deckExists) {
        return notFound(res, 'DECK_NOT_FOUND');
    }

    await questionsService.create(deckId, question)
        .then(question => res.status(200).json(question))
        .catch(err => internalError(res, err));
}

const getAll = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const deckId = parseInt(req.params.deckId);

    if (!deckId) {
        return badRequest(res, 'INVALID_DECK_ID');
    }

    await questionsService.getAll(deckId)
        .then(questions => {
            if (questions) {
                return res.json(questions);
            }
            return notFound(res, 'QUESTION_NOT_FOUND');
        })
        .catch(err => internalError(res, err));
}

const remove = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const deckId = parseInt(req.params.deckId);

    if (!deckId) {
        return badRequest(res, 'INVALID_CATEGORY_ID');
    }


    const questionId = parseInt(req.params.id);

    if (!questionId) {
        return badRequest(res, 'INVALID_QUESTION_ID');
    }

    const questionExists = await questionsService.checkIfQuestionExists(questionId);

    if (!questionExists) {
        return notFound(res, 'QUESTION_NOT_FOUND');
    }

    await questionsService.remove(deckId, questionId)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

export const questionsController = {
    create,
    getAll,
    remove,
}