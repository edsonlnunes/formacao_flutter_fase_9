import { Request, Response } from "express";
import { User } from "../models/user.model";
import { usersService } from "../services/users.service";
import { badRequest, internalError, notFound } from "../utils/req-errors.util";

const create = async (req: Request, res: Response) => {
    const user =  req.body as User;

    if (!user) {
        return badRequest(res, 'INVALID_USER');
    }

    if(!user.email) {
        return badRequest(res, 'INVALID_USER_EMAIL');
    }

    if (!user.password) {
        return badRequest(res, 'INVALID_USER_PASSWORD');
    }

    const userExists = await usersService.checkIfUserExists(user.email);

    if (userExists) {
        return badRequest(res, 'USER_ALREADY_EXISTS');
    }

    await usersService.create(user)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

const login = async (req: Request, res: Response) => {
    const user = req.body as User;

    if (!user) {
        return badRequest(res, 'INVALID_USER');
    }

    if(!user.email) {
        return badRequest(res, 'INVALID_USER_EMAIL');
    }

    if (!user.password) {
        return badRequest(res, 'INVALID_USER_PASSWORD');
    }

    const userExists = await usersService.checkIfUserExists(user.email, user.password);

    if (!userExists) {
        return notFound(res, 'EMAIL_OR_PASSWORD_INCORRECTS');
    }

    await usersService.login(user.email, user.password)
        .then(token => res.status(200).json(token))
        .catch(err => internalError(res, err));
}

export const usersController = {
    create,
    login,
}