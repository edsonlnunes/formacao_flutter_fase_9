export const extractUserIdFromToken = (token: string): number => {
    const parts = token.split('_');
    return parseInt(parts[3]);
};
