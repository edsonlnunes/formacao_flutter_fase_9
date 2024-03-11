import { Category } from "../models/category.model";
import { dbQuery } from "./db.service";

const checkIfCategoryExists = async (categoryId: number): Promise<boolean> => {
    const categories = await dbQuery(
        'SELECT * FROM categories WHERE id = ?',
        [categoryId],
    );
    
    return (categories as Category[])[0] !== undefined;
};

const create = async (userId: number, category: Category) => {
    await dbQuery(
        'INSERT INTO categories (name, file_path, user_id) VALUES(?, ?, ?)',
        [category.name, category.filePath, userId],
    );

    const lastContentId = await dbQuery('SELECT id from categories order by ROWID DESC limit 1') as any;

    const categoryDB = await dbQuery(
        'SELECT id, name, file_path FROM categories WHERE id = ?',
        [lastContentId[0]['id']],
    ) as any;

    return {
        id: categoryDB[0].id,
        name: categoryDB[0].name,
        filePath: categoryDB[0].file_path,
    } as Category;
}

const getAll = async (userId: number) => {
    const categories = await dbQuery(
        'SELECT * FROM categories WHERE categories.user_id = ?',
        [userId],
    );

    const mappedCategories = (categories as Category[]).map((category: any) => {
        return {
            id: category.id,
            name: category.name,
            filePath: category.file_path,
        }
    });

    return mappedCategories;
}

const remove = async (id: number) => {
    await dbQuery(
        'DELETE FROM categories WHERE id = ?',
        [id],
    );
}

export const categoriesService = {
    checkIfCategoryExists,
    create,
    getAll,
    remove,
}