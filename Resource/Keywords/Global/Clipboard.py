import pyperclip
class Clipboard(): 

    @staticmethod
    def pasteText() -> str:
        text = pyperclip.paste()
        return text

    @staticmethod
    def copyText (stringText: str) -> str: 
        pyperclip.copy(stringText)
        text = pyperclip.paste()
        return text
        
    @staticmethod
    def clearText(): 
        pyperclip.copy('')
