import { Question } from "./question.model";

export type Deck = {
    id: number;
    name: string;
    questions: Question[];
}
