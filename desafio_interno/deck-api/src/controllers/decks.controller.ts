import { Request, Response } from "express";
import { Deck } from "../models/deck.model";
import { decksService } from "../services/decks.service";
import { extractUserIdFromToken } from "../utils/extract-user-id-from-token.util";
import { badRequest, internalError, notFound, unauthorized } from "../utils/req-errors.util";

const create = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);
    const deck =  req.body as Deck;

    if (!deck) {
        return badRequest(res, 'INVALID_DECK');
    }

    if (!deck.name) {
        return badRequest(res, 'INVALID_DECK_NAME');
    }

    await decksService.create(userId, deck)
        .then(deck => res.status(200).json(deck))
        .catch(err => internalError(res, err));
}

const getAll = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);

    await decksService.getAll(userId)
        .then(users => {
            if (users) {
                return res.json(users);
            }
            return notFound(res, 'DECK_NOT_FOUND');
        })
        .catch(err => internalError(res, err));
}

const remove = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const deckId = parseInt(req.params.id);

    if (!deckId) {
        return badRequest(res, 'INVALID_DECK_ID');
    }

    const deckExists = await decksService.checkIfDeckExists(deckId);

    if (!deckExists) {
        return notFound(res, 'DECK_NOT_FOUND');
    }

    await decksService.remove(deckId)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

export const decksController = {
    create,
    getAll,
    remove,
}