import { Application, Router } from 'express';
import { usersRouter } from './users.routes';
import { decksRouter } from './decks.routes';
import { questionsRouter } from './questions.routes';

export const initRoutes = (app: Application) => {
    const apiRouter = Router();

    apiRouter.use('/', usersRouter);
    apiRouter.use('/', decksRouter);
    apiRouter.use('/', questionsRouter);
    app.use('/api', apiRouter);
}