import ja from './ja'
import en from './en'

export const getMessages = locale => locale === 'en' ? en : ja
