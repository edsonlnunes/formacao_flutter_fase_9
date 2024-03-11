import { Router } from 'express';
import { questionsController } from '../controllers/questions.controller';

const questionsRouter = Router();

questionsRouter.post('/decks/:deckId/questions', questionsController.create);
questionsRouter.get('/decks/:deckId/questions', questionsController.getAll);
questionsRouter.delete('/decks/:deckId/questions/:id', questionsController.remove);

export {
    questionsRouter
};
