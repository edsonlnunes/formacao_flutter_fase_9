import { Request, Response } from "express";
import { Category } from "../models/category.model";
import { categoriesService } from "../services/categories.service";
import { extractUserIdFromToken } from "../utils/extract-user-id-from-token.util";
import { badRequest, internalError, notFound, unauthorized } from "../utils/req-errors.util";

const create = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);
    const category =  req.body as Category;

    if (!category) {
        return badRequest(res, 'INVALID_CATEGORY');
    }

    if(!category.name) {
        return badRequest(res, 'INVALID_CATEGORY_NAME');
    }

    await categoriesService.create(userId, category)
        .then(category => res.status(200).json(category))
        .catch(err => internalError(res, err));
}

const getAll = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);

    await categoriesService.getAll(userId)
        .then(users => {
            if (users) {
                return res.json(users);
            }
            return notFound(res, 'CATEGORY_NOT_FOUND');
        })
        .catch(err => internalError(res, err));
}

const remove = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const categoryId = parseInt(req.params.id);

    {
        if (!categoryId) {
            return badRequest(res, 'INVALID_CATEGORY_ID');
        }
    }

    const categoryExists = await categoriesService.checkIfCategoryExists(categoryId);

    if (!categoryExists) {
        return notFound(res, 'CATEGORY_NOT_FOUND');
    }

    await categoriesService.remove(categoryId)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

export const categoriesController = {
    create,
    getAll,
    remove,
}