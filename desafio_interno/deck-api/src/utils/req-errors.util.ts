import { Response } from "express";

export const badRequest = (res: Response, err: string) => {
    res.status(400).json({error: err});
}

export const unauthorized = (res: Response) => {
    res.status(401).json({error: 'UNAUTHORIZED_USER'});
}

export const notFound = (res: Response, err: string) => {
    res.status(404).json({error: err});
}

export const internalError = (res: Response, err: Error) => {
    res.status(500).json({error: err.message});
}