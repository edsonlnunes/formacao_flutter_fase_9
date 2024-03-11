import { Router } from 'express';
import { usersController } from '../controllers/users.controller';

const usersRouter = Router();

usersRouter.post('/login', usersController.login);
usersRouter.post('/register', usersController.create);

export {
    usersRouter,
}