import { Router } from 'express';
import { contentsController } from '../controllers/contents.controller';

const contentsRouter = Router();

contentsRouter.post('/categories/:categoryId/contents', contentsController.create);
contentsRouter.get('/categories/:categoryId/contents', contentsController.getAll);
contentsRouter.delete('/categories/:categoryId/contents/:id', contentsController.remove);
contentsRouter.put('/categories/:categoryId/contents/:id', contentsController.update);

export {
    contentsRouter
};
