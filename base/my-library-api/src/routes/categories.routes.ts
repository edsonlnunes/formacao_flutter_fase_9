import { Router } from 'express';
import { categoriesController } from '../controllers/categories.controller';

const categoriesRouter = Router();

categoriesRouter.post('/categories', categoriesController.create);
categoriesRouter.get('/categories', categoriesController.getAll);
categoriesRouter.delete('/categories/:id', categoriesController.remove);

export {
    categoriesRouter,
}