import { Application, Router } from 'express';
import { categoriesRouter } from './categories.routes';
import { contentsRouter } from './contents.routes';
import { usersRouter } from './users.routes';

export const initRoutes = (app: Application) => {
    const apiRouter = Router();

    apiRouter.use('/', usersRouter);
    apiRouter.use('/', categoriesRouter);
    apiRouter.use('/', contentsRouter);
    app.use('/api', apiRouter);
}