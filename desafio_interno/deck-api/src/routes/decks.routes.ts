import { Router } from 'express';
import { decksController } from '../controllers/decks.controller';

const decksRouter = Router();

decksRouter.post('/decks', decksController.create);
decksRouter.get('/decks', decksController.getAll);
decksRouter.delete('/decks/:id', decksController.remove);

export {
    decksRouter,
}