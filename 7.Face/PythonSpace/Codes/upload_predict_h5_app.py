from flask import Flask, request, jsonify # flutter 는 반드시 json 으로 넘겨주기
from werkzeug.utils import secure_filename
import os
from PIL import Image
import numpy as np
from tensorflow import keras


app = Flask(__name__)

@app.route('/uploader',methods = ['GET','POST'])
def uploader():
    f = request.files['image'] # 앱쪽은 image 라고 변수 이름을 준다.
    os.chdir("./images")
    f.save(secure_filename(f.filename))
    # ---------------
    
    num_of_data = 1
    img_width_size = 300
    img_height_size = 400
    
    testImage = np.zeros(num_of_data * img_width_size * img_height_size).reshape(num_of_data, img_height_size, img_width_size)
    img = np.array(Image.open(f.filename),dtype = np.int32)
    testImage[0,:,:] = img
    
    dirNames = ['Aiden','Andrew','Cathy']
    os.chdir('..')
    model2 = keras.models.load_model("./best-gray-cnn-model.h5")
    preds = model2.predict(testImage[0:1])
    return jsonify({'result': dirNames[np.argmax(preds[0])]})

if __name__ == '__main__':
    app.run(host = '127.0.0.1', port= 5000, debug= True)
    