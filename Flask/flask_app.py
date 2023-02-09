from flask import Flask,request
from flask_restful import Api
from translate import Translator
import requests
import easyocr
from PIL import Image
import requests
from io import BytesIO
from urllib.parse import unquote

def myvalue(url):
    response = requests.get(url)
    img = Image.open(BytesIO(response.content))
    return img


def reads(image1):
    read = easyocr.Reader(['ta','en'])
    bounds = read.readtext(image1)
    return bounds[0][1]

def translate(name):
    trans = Translator(from_lang='ta',to_lang='en')
    result = trans.translate(name)
    return result

app = Flask(__name__)
api = Api(app)

@app.route('/service',methods=['GET'])
def find():
    try:
     if request.method=='GET':
        print(request.args['url']) 
        img1 = myvalue(str(request.args['url']))
        name = reads(img1)
        english_name = translate(name)
        print(english_name)
        return english_name
    except:
        return "null"

if __name__ == '__main__':
    app.run()