import { Content } from "../models/content.model";
import { dbQuery } from "./db.service";

const checkIfContentExists = async (contentId: number): Promise<boolean> => {
    const contents = await dbQuery(
        'SELECT * FROM contents WHERE id = ?',
        [contentId],
    );
    
    return (contents as Content[])[0] !== undefined;
};

const create = async (categoryId: number, content: Content) => {
    await dbQuery(
        'INSERT INTO contents (name, is_checked, category_id) VALUES(?, 0, ?)',
        [content.name, categoryId],
    );

    const lastContentId = await dbQuery('SELECT id from contents order by ROWID DESC limit 1') as any;

    const contentDB = await dbQuery(
        'SELECT id, name, is_checked FROM contents WHERE category_id = ? AND id = ?',
        [categoryId, lastContentId[0]['id']],
    ) as any;

    return {
        id: contentDB[0].id,
        name: contentDB[0].name,
        isChecked: contentDB[0].is_checked === 1,
    } as Content;
}

const getAll = async (categoryId: number) => {
    const contents = await dbQuery(
        'SELECT * FROM contents WHERE contents.category_id = ?',
        [categoryId],
    );

    const mappedContents = (contents as Content[]).map((content: any) => {
        const isChecked = content.is_checked === 1;

        return {
            id: content.id,
            name: content.name,
            isChecked,
        };
    });

    return mappedContents;
}

const remove = async (categoryId: number, id: number) => {
    await dbQuery(
        'DELETE FROM contents WHERE category_id = ? AND id = ?',
        [categoryId, id],
    );
}

const update = async (categoryId: number, id: number, isChecked: number) => {
    await dbQuery(
        'UPDATE contents SET is_checked = ? WHERE category_id = ? AND id = ?',
        [isChecked, categoryId, id],
    );

    const isCheckedDB = await dbQuery(
        'SELECT is_checked FROM contents WHERE category_id = ? AND id = ?',
        [categoryId, id],
    );

    return isCheckedDB === 1;
}


export const contentsService = {
    checkIfContentExists,
    create,
    getAll,
    remove,
    update,
}