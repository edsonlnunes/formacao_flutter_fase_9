import { Request, Response } from "express";
import { Content } from "../models/content.model";
import { categoriesService } from "../services/categories.service";
import { contentsService } from "../services/contents.service";
import { badRequest, internalError, notFound, unauthorized } from "../utils/req-errors.util";

const create = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const categoryId = parseInt(req.params.categoryId);

    {
        if (!categoryId) {
            return badRequest(res, 'INVALID_CATEGORY_ID');
        }
    }

    const content =  req.body as Content;

    if (!content) {
        return badRequest(res, 'INVALID_CONTENT');
    }

    if(!content.name) {
        return badRequest(res, 'INVALID_CONTENT_NAME');
    }

    const categoryExists = await categoriesService.checkIfCategoryExists(categoryId);

    if (!categoryExists) {
        return notFound(res, 'CATEGORY_NOT_FOUND');
    }

    await contentsService.create(categoryId, content)
        .then(content => res.status(200).json(content))
        .catch(err => internalError(res, err));
}

const getAll = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const categoryId = parseInt(req.params.categoryId);

    {
        if (!categoryId) {
            return badRequest(res, 'INVALID_CATEGORY_ID');
        }
    }

    await contentsService.getAll(categoryId)
        .then(contents => {
            if (contents) {
                return res.json(contents);
            }
            return notFound(res, 'CONTENT_NOT_FOUND');
        })
        .catch(err => internalError(res, err));
}

const remove = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const categoryId = parseInt(req.params.categoryId);

    if (!categoryId) {
        return badRequest(res, 'INVALID_CATEGORY_ID');
    }

    const contentId = parseInt(req.params.id);

    if (!contentId) {
        return badRequest(res, 'INVALID_CONTENT_ID');
    }
    

    const contentExists = await contentsService.checkIfContentExists(contentId);

    if (!contentExists) {
        return notFound(res, 'CONTENT_NOT_FOUND');
    }

    await contentsService.remove(categoryId, contentId)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

const update = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const categoryId = parseInt(req.params.categoryId);

    if (!categoryId) {
        return badRequest(res, 'INVALID_CATEGORY_ID');
    }

    const contentId = parseInt(req.params.id);

    if (!contentId) {
        return badRequest(res, 'INVALID_CONTENT_ID');
    }

    const isChecked = req.body.isChecked;

    if (typeof isChecked !== 'boolean') {
        return badRequest(res, 'INVALID_IS_CHECKED');
    }

    const contentExists = await contentsService.checkIfContentExists(contentId);

    if (!contentExists) {
        return notFound(res, 'CONTENT_NOT_FOUND');
    }

    await contentsService.update(categoryId, contentId, isChecked ? 1 : 0)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

export const contentsController = {
    create,
    getAll,
    remove,
    update,
}